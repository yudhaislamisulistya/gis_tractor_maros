import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Info/info_screen.dart';
import 'package:thesisgisproject/Screens/Profile/disclaimer_screen.dart';
import 'package:thesisgisproject/Screens/Profile/privacy_policy_screen.dart';
import 'package:thesisgisproject/Screens/Profile/setting_screen.dart';
import 'package:thesisgisproject/Screens/Profile/term_and_conditions_screen.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:thesisgisproject/screens/login/login_screen.dart';

class ComponentSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final String docId;
  final String fullname;
  final String email;
  final String numberPhone;

  ComponentSetting(
      {this.icon,
      this.title,
      this.docId,
      this.fullname,
      this.email,
      this.numberPhone});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: new BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: new ListTile(
        leading: new Icon(
          icon,
        ),
        title: new Text(
          title,
          style: kTitleTextstyle,
        ),
        trailing: new IconButton(
          icon: new Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return selectScreenWithIf(
                      title, docId, fullname, email, numberPhone);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

dynamic selectScreenWithIf(title, docId, fullname, email, numberPhone) {
  dynamic data;
  if (title == "Setting") {
    data = new SettingScreen(
      docId: docId,
      fullname: fullname,
      email: email,
      numberPhone: numberPhone,
    );
  } else if (title == "Privacy Policy") {
    data = new PrivacyPolicyScreen();
  } else if (title == "Disclaimer") {
    data = new DisclaimerScreen();
  } else if (title == "Term & Conditions") {
    data = new TermAndConditions();
  } else if (title == "Apps") {
    data = new InfoScreen();
  } else if (title == "Logout") {
    data = new LoginScreen();
  }
  return data;
}
