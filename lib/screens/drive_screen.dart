import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_screen.dart';

class DriveScreen extends StatefulWidget {
  static const String id = 'driveScreen';

  @override
  _DriveScreenState createState() => _DriveScreenState();
}

class _DriveScreenState extends State<DriveScreen> {
  String tkn = "";
  void setItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF8500),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(
                top: 50,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(color: Color(0xffFF8500)),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await setItem();
                          setState(() {
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          });
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Karma Drives',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Expanded(
                        child: Material(
                          elevation: 2,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(150)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12,
                            ),
                            child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushNamed(
                                        context, ProfileScreen.id);
                                  });
                                },
                                child: Text(
                                  'MY DRIVES',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(1),
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: 'Search here...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            filled: true,
                            suffix: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              ),
              child: ListView(
                children: [
                  Image.asset(
                    'images/drive.png',
                  ),
                  Image.asset(
                    'images/drive.png',
                  ),
                  Image.asset(
                    'images/drive.png',
                  ),
                  Image.asset(
                    'images/drive.png',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
