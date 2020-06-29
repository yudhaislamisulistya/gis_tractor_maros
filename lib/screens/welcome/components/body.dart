import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Login/login_screen.dart';
import 'package:thesisgisproject/Screens/Signup/signup_screen.dart';
import 'package:thesisgisproject/Screens/Welcome/components/background.dart';
import 'package:thesisgisproject/Screens/components/fade_animation.dart';
import 'package:thesisgisproject/components/rounded_button.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FadeAnimation(
              0.3,
              Text(
                "GIS TRACTOR MAROS",
                style: new TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            new FadeAnimation(
              0.4,
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            new FadeAnimation(
              0.5,
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            new FadeAnimation(
              0.6,
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
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
            ),
          ],
        ),
      ),
    );
  }
}
