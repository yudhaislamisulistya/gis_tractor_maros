import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thesisgisproject/Screens/Welcome/welcome_screen.dart';
import 'package:thesisgisproject/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIS Tractor',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
