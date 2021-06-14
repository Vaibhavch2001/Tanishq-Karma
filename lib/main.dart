import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/drive_screen.dart';
import 'screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(KarmaApp());
}

class KarmaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            backgroundColor: Colors.white,
            textTheme: GoogleFonts.openSansTextTheme()),
        home: LoginScreen(),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          DriveScreen.id: (context) => DriveScreen(),
          ProfileScreen.id: (context) => ProfileScreen()
        });
  }
}
