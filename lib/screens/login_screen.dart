import 'dart:ui';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../Api/api.dart';
import 'drive_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passVisible = true;
  String email, password;
  String tkn = "";
  void getItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tkn = await prefs.getString('token') ?? "";
    print(tkn);
    print('halo');
    if (tkn != "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("", tkn);
      Navigator.popAndPushNamed(context, DriveScreen.id);
    }
    // await prefs.setString('name', fieldname);
  }

  void setItem(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
                  color: Color(0xffFF8500)),
              child: Image.asset(
                'images/karna.png',
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 45,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your e-mail',
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 45,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        obscureText: passVisible,
                        decoration: kTextFieldDecoration.copyWith(
                            suffix: IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      if (passVisible == true) {
                                        passVisible = false;
                                      } else
                                        passVisible = true;
                                    },
                                  );
                                },
                                icon: Icon(
                                  passVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                )),
                            hintText: 'Enter your password'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                  ),
                  RoundedButton(
                      onpressed: () async {
                        LoginUser l1 = LoginUser(email, password);
                        String token = await l1.postInfo();
                        setState(() {
                          if (token != null) {
                            setItem(token);
                            Navigator.popAndPushNamed(context, DriveScreen.id);
                          } else {
                            Alert(context: context, title: 'User not found');
                          }
                        });
                      },
                      color: Colors.lightGreen,
                      text: 'Login'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member yet?'),
                      TextButton(
                          onPressed: null,
                          child: Text(
                            'Click Me',
                            style: TextStyle(color: Colors.orange),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onpressed;
  RoundedButton({this.onpressed, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
