import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/staticData.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _usermobile = TextEditingController();
  AppConfig appConfig;
  @override
  void initState() {
    super.initState();
    _username.text = 'Nitika Bhatta';
    _userEmail.text = 'nitika.bhatta@kathford.edu.np';
    _usermobile.text = '';
  }

  Future toast() {
    return Fluttertoast.showToast(
      msg: "Saved",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromRGBO(47, 11, 69, 1),
                //     Color.fromRGBO(19, 13, 75, 1),
                //   ],
                // ),
                ),
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(StaticData.imagepath + 'banner.png'),
                  fit: BoxFit.fill,
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(47, 11, 69, 1),
                    Color.fromRGBO(19, 13, 75, 1),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 55,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black38,
                        ),
                      ],
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        StaticData.imagepath + 'image2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.718,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: appConfig.rHP(5),
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 17),
                              alignment: Alignment.center,
                              width: 350,
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blueAccent,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        // bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.black12,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 280,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      controller: _username,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: Colors.blueAccent),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 17),
                              alignment: Alignment.center,
                              width: 350,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.blueAccent,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.black12,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 280,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _userEmail,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Colors.blueAccent),
                                        border: InputBorder.none,
                                        // counterText: 'adad',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 350,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.call_outlined,
                                      color: Colors.blueAccent,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.black12,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 280,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      controller: _usermobile,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Mobile',
                                        labelStyle:
                                            TextStyle(color: Colors.blueAccent),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: appConfig.rHP(6),
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 17),
                              alignment: Alignment.center,
                              width: 350,
                              // color: Colors.red,
                              child: GestureDetector(
                                onTap: () {
                                  toast();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(79, 139, 241, 1),
                                        Color.fromRGBO(153, 92, 228, 1),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7,
                                        color: Colors.black12,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  width: 100,
                                  height: 40,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Spacer(),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.07,
                            // ),
                            // Container(
                            //   // color: Colors.red,
                            //   width: MediaQuery.of(context).size.width,
                            //   height: MediaQuery.of(context).size.height - 618,
                            //   child: Image.asset(
                            //     StaticData.imagepath + '2.png',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
