import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
import 'package:thesisgisproject/Screens/Login/components/background.dart';
import 'package:thesisgisproject/Screens/Signup/signup_screen.dart';
import 'package:thesisgisproject/components/already_have_an_account_acheck.dart';
import 'package:thesisgisproject/components/rounded_button.dart';
import 'package:thesisgisproject/components/rounded_input_field.dart';
import 'package:thesisgisproject/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesisgisproject/screens/home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String emailCorrect;
  String passwordCorrect;
  String currentEmail;
  String currentPassword;

  checkDataUser(email, password) async {
    return await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .getDocuments();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: new TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                currentEmail = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                currentPassword = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (currentEmail == null || currentPassword == null) {
                  return StatusAlert.show(
                    context,
                    duration: Duration(seconds: 2),
                    title: 'Error',
                    subtitle: 'Masih Ada Data Yang Kosong',
                    configuration: IconConfiguration(icon: Icons.close),
                  );
                } else {
                  checkDataUser(currentEmail, currentPassword).then((results) {
                    setState(() {
                      emailCorrect = results.documents[0].data["email"];
                      passwordCorrect = results.documents[0].data["password"];
                      if (currentEmail == emailCorrect &&
                          currentPassword == passwordCorrect) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return new HomeScreen(
                                email: emailCorrect,
                              );
                            },
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    });
                  }).catchError((e){
                    return StatusAlert.show(
                      context,
                      duration: Duration(seconds: 2),
                      title: 'Error',
                      subtitle:
                      'Email atau Kata Sandi Keliru',
                      configuration: IconConfiguration(icon: Icons.close),
                    );
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
