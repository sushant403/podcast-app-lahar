import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/model/users.dart';
import 'package:songapp/screens/Home.dart';
import 'package:songapp/screens/login/loginscreen.dart';
import 'package:songapp/screens/signup/background.dart';
import 'package:songapp/staticData.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String username = '';
  String email = '';
  // String number = '';
  String password = '';
  // String usercity = '';
  bool _showPassword = true;
  SignupUser _future;
  SharedPreferences sharedPreferences;

  final GlobalKey<FormState> _formKey = GlobalKey();
  onpress() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await Networkutils()
        .postSignup(
      email,
      password,
      username,
    )
        .then((value) {
      setState(() {
        _future = value;
      });
    });
    try {
      if (_future.result[0] == null) {
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
    // MyData.myName = _future.result[0].userId;
    // MyData.myImage = _future.result[0].userProfilePic;
    sharedPreferences.setBool("isfirst", false);
    sharedPreferences.setString("name", _future.result[0].userId);
    sharedPreferences.setString("email", _future.result[0].userEmail);
    sharedPreferences.setString("username", _future.result[0].userName);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(),
      ),
    );
  }

  googlesignup(String email, String name, String imageUrl) async {
    // final response = await http.get(Uri.parse(imageUrl));
    print(imageUrl);
    // MyData.myImage = imageUrl;
    if (mounted) {
      // String base = base64.encode(response.bodyBytes);
      // print(base);
      await Networkutils()
          .postGoogleSignUp(
        email,
        '',
        name,
      )
          .then((value) {
        setState(() {
          _future = value;
        });
      });
      try {
        if (_future.result[0] == null) {
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
      // MyData.myName = _future.result[0].userId;
      // MyData.googleImage = imageUrl;
      sharedPreferences.setBool("isfirst", false);
      sharedPreferences.setString("name", _future.result[0].userId);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<User> signInWithGoogle(BuildContext context) async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

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
  //   googlesignup(user.email, user.displayName, user.photoURL);

  //   return user;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGround(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.2),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
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
                    child: TextFormField(
                      onSaved: (value) {
                        username = value;
                      },
                      keyboardType: TextInputType.text,

                      cursorColor: Color.fromRGBO(60, 211, 173, 1),
                      // controller: _controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Container(
                          // height: 1,
                          child: Image.asset(
                            StaticData.imagepath + 'ic_profile' + '.png',
                            scale: 1.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
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
                    child: TextFormField(
                      onSaved: (value) {
                        email = value;
                      },
                      cursorColor: Color.fromRGBO(60, 211, 173, 1),
                      // controller: _controller,
                      keyboardType: TextInputType.emailAddress,

                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Container(
                          // height: 1,
                          child: Image.asset(
                            StaticData.imagepath + 'ic_email' + '.png',
                            scale: 2.9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
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
                    child: TextFormField(
                      onSaved: (value) {
                        password = value;
                      },
                      style: TextStyle(color: Colors.black),
                      obscureText: _showPassword,
                      cursorColor: Color.fromRGBO(60, 211, 173, 1),
                      keyboardType: TextInputType.text,
                      // controller: _passcontroller,
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
                  height: 25,
                ),
                SizedBox(
                  height: 30,
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
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Or SignUp with',
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
                          child: Image.asset(
                              StaticData.imagepath + 'ic_google.png'),
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
                      'Already have an account?',
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
                            builder: (ctx) => LoginScreen(),
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
                          'Sign In',
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
      ),
    );
  }
}
