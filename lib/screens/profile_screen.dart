import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditable = true;
  bool status = false;
  String name = "", location = "", number = "", interest = "";
  TextEditingController nameC = TextEditingController(),
      locationC = TextEditingController(),
      numberC = TextEditingController(),
      interestC = TextEditingController();
  void getItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? "";
    location = prefs.getString('location') ?? "";
    number = prefs.getString('number') ?? "";
    interest = prefs.getString('interest') ?? "";

    if (name != "") nameC.text = name;
    if (location != "") locationC.text = location;
    if (interest != "") interestC.text = interest;
    if (number != "") numberC.text = number;

    // await prefs.setString('name', fieldname);
  }

  void setItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('location', location);
    await prefs.setString('number', number);
    await prefs.setString('interest', interest);
    // await prefs.setString('name', fieldname);
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
      backgroundColor: Color(0xffFF8500),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 50,
              left: 15,
              right: 15,
            ),
            decoration: BoxDecoration(
              color: Color(0xffFF8500),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xffff9e31),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 190,
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                setItem();
                                print(location);
                                if (isEditable) {
                                  isEditable = false;
                                } else
                                  isEditable = true;
                              },
                            );
                          },
                          icon: Icon(
                            isEditable ? Icons.save : Icons.edit,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage("images/drive.png"),
            radius: 60.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        width: 165,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileField(
                          editable: isEditable,
                          controller: nameC,
                          onpressed: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          hintText: 'Enter Name',
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        ProfileField(
                          editable: isEditable,
                          controller: numberC,
                          onpressed: (value) {
                            setState(() {
                              number = value;
                            });
                          },
                          hintText: 'Enter Phone Number',
                        ),
                      ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      'Location',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 145,
                    ),
                    Text(
                      'Interest',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileField(
                        editable: isEditable,
                        controller: locationC,
                        onpressed: (value) {
                          setState(() {
                            location = value;
                          });
                        },
                        hintText: 'Enter Location',
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ProfileField(
                        editable: isEditable,
                        controller: interestC,
                        onpressed: (value) {
                          setState(() {
                            interest = value;
                          });
                        },
                        hintText: 'Enter Interest',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      FlutterSwitch(
                        inactiveColor: Colors.grey[300],
                        activeColor: Color(0xffFF8500),
                        toggleColor: Colors.orangeAccent,
                        value: status,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      )
                    ],
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

class ProfileField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onpressed;
  bool editable;
  ProfileField(
      {@required this.hintText,
      @required this.onpressed,
      this.editable,
      this.controller});

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      height: 40,
      child: TextField(
        controller: widget.controller,
        enabled: widget.editable,
        onChanged: widget.onpressed,
        decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            fillColor: Colors.grey[300],
            filled: true),
      ),
    ));
  }
}
