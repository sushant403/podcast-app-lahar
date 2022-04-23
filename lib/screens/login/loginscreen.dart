// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/model/users.dart';
import 'package:songapp/screens/Home.dart';
import 'package:songapp/screens/login/background.dart';
import 'package:songapp/screens/signup/signupscreen.dart';
import 'package:songapp/staticData.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  bool _showPassword = true;

  Widget buildTextfield(
      String title, String image, TextEditingController _controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color:
              // Color.fromRGBO(74, 188, 193, 1),
              Color.fromRGBO(60, 211, 173, 1),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: TextField(
          cursorColor: Color.fromRGBO(60, 211, 173, 1),
          controller: _controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            border: InputBorder.none,
            prefixIcon: Container(
              // height: 1,
              child: Image.asset(
                StaticData.imagepath + image + '.png',
                scale: 1.7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SharedPreferences sharedPreferences;
  List<Users> _data;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<User> signInWithGoogle(BuildContext context) async {
  //   Center(
  //     child: Container(
  //       height: 300,
  //       child: Card(
  //         child: Row(
  //           children: <Widget>[
  //             CircularProgressIndicator(),
  //             Text('Loading'),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //   Center(
  //     child: CircularProgressIndicator(),
  //   );
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final User user = (await _auth.signInWithCredential(credential)).user;
  //   print("signed in " + user.displayName);

  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final User currentUser = _auth.currentUser;
  //   assert(user.uid == currentUser.uid);
  //   googlesignin(
  //     user.email,
  //     user.photoURL,
  //   );

  //   return user;
  // }

  googlesignin(
    String email,
    // String name,
    String imageUrl,
  ) async {
    if (mounted) {
      await Networkutils().postGoogleSignin(email, '1').then((value) {
        setState(() {
          _data = value;
        });
      });
      try {
        if (_data[0].userId == null) {
          print('object');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('check Your credetials!')));
          return;
        }
      } on RangeError catch (_) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User is Already Registered!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

      // MyData.googleImage = imageUrl;
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool("isfirst", false);
      sharedPreferences.setString("name", _data[0].userId);
      sharedPreferences.setString("email", _data[0].userEmail);
      sharedPreferences.setString("username", _data[0].userName);
      // MyName.email = _data[0].userEmail;
      // MyName.name = _data[0].userName;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
  }

  onpress() async {
    if (_emailcontroller.text == null && _passcontroller == null) {
      print('object');
      return;
    }
    await Networkutils()
        .postlogin(
      _emailcontroller.text,
      _passcontroller.text,
    )
        .then((value) {
      setState(() {
        _data = value;
      });
    });
    try {
      if (_data[0].userId == null) {
        print('object');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('check Your credetials!')));
        return;
      }
    } on RangeError catch (_) {
      // Navigator.of(context).pop();
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check Your Credentials!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    print(_data[0].userProfilePic);
    // MyData.myName = _data[0].userId;
    // MyData.myImage = _data[0].userProfilePic;
    print("object");
    print(_data[0].userId);
    // print(MyData.myImage);
    // await datasave();
    sharedPreferences.setBool("isfirst", false);
    sharedPreferences.setString("name", _data[0].userId);
    sharedPreferences.setString("email", _data[0].userEmail);
    sharedPreferences.setString("username", _data[0].userName);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGround(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              buildTextfield('Email', 'ic_profile', _emailcontroller),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(60, 211, 173, 1),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    obscureText: _showPassword,
                    cursorColor: Color.fromRGBO(60, 211, 173, 1),
                    controller: _passcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: _showPassword
                            ? FaIcon(
                                FontAwesomeIcons.eye,
                              )
                            : FaIcon(
                                FontAwesomeIcons.eyeSlash,
                              ),
                        color: Colors.black,
                      ),
                      prefixIcon: Container(
                        // height: 1,
                        child: Image.asset(
                          StaticData.imagepath + 'ic_password' + '.png',
                          scale: 2.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(right: 24),
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(60, 211, 173, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  // onpress();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 13),
                  alignment: Alignment.center,
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(153, 92, 228, 1),
                        Color.fromRGBO(0, 239, 215, 1).withOpacity(0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Or Login with',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Image.asset(StaticData.imagepath + 'ic_fb.png'),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          // signInWithGoogle(context);
                        },
                        child:
                            Image.asset(StaticData.imagepath + 'ic_google.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account yet?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => SignupScreen(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 39,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(32, 173, 149, 1),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
