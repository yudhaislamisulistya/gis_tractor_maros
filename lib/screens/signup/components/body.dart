import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
import 'package:thesisgisproject/Screens/Login/login_screen.dart';
import 'package:thesisgisproject/Screens/Signup/components/background.dart';
import 'package:thesisgisproject/blocs/user.dart';
import 'package:thesisgisproject/components/already_have_an_account_acheck.dart';
import 'package:thesisgisproject/components/rounded_button.dart';
import 'package:thesisgisproject/components/rounded_input_field.dart';
import 'package:thesisgisproject/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesisgisproject/components/rounded_repeat_password_field.dart';

class Body extends StatelessWidget {

  String email;
  String password;
  String repeatPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: new TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedRepeatPasswordField(
              onChanged: (value) {
                repeatPassword = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                if(email == null || password == null || repeatPassword == null){
                  return StatusAlert.show(
                    context,
                    duration: Duration(seconds: 2),
                    title: 'Error',
                    subtitle: 'Masih Ada Data Yang Kosong',
                    configuration: IconConfiguration(icon: Icons.close),
                  );
                }else{
                  if(password == repeatPassword){
                    dynamic userData = {
                      "email": email,
                      "password": password,
                      "nama_lengkap": "",
                      "no_telp": "",
                      "created_at": DateTime.now(),
                      "updated_at": DateTime.now(),
                    };
                    userBloc.addDataUser(userData);
                    return StatusAlert.show(
                      context,
                      duration: Duration(seconds: 2),
                      title: 'Success',
                      subtitle: 'Berhasil Mendaftar',
                      configuration: IconConfiguration(icon: Icons.done),
                    );
                  }else{
                    return StatusAlert.show(
                      context,
                      duration: Duration(seconds: 2),
                      title: 'Error',
                      subtitle: 'Password Tidak Sama, Silahkan Pastikan Kembali',
                      configuration: IconConfiguration(icon: Icons.close),
                    );
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
          ],
        ),
      ),
    );
  }
}
