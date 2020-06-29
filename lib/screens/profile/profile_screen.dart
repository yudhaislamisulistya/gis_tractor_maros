import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Dashboard/components/my_header.dart';
import 'package:thesisgisproject/Screens/Profile/components/settings.dart';
import 'package:thesisgisproject/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  ProfileScreen({this.email});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = ScrollController();
  double offset = 0;
  String fullname;
  String email;
  String numberPhone;
  String docId;

  getDataUserByEmail(email) async {
    return await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUserByEmail(widget.email).then((results) {
      setState(() {
        fullname = results.documents[0].data["nama_lengkap"];
        email = results.documents[0].data["email"];
        numberPhone = results.documents[0].data["no_telp"];
        docId = results.documents[0].documentID;
      });
    });

    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: new SingleChildScrollView(
        controller: controller,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/profile.svg",
              textTop: "GIS Tractor",
              textBottom: "Profile",
              offset: offset,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Account Information",
                      style: kTitleTextstyle,
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: AssetImage('assets/images/man-avatar.png'),
                          ),
                        ),
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(
                        fullname == null ? "" : fullname,
                        style: new TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      new Text(
                        email == null ? "" : email,
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            ComponentSetting(
              title: "Setting",
              icon: Icons.settings,
              docId: docId,
              fullname: fullname,
              email: email,
              numberPhone: numberPhone,
            ),
            ComponentSetting(
              title: "Privacy Policy",
              icon: Icons.priority_high,
            ),
            ComponentSetting(
              title: "Disclaimer",
              icon: Icons.do_not_disturb_on,
            ),
            ComponentSetting(
              title: "Term \& Conditions",
              icon: Icons.assistant_photo,
            ),
            ComponentSetting(
              title: "Apps",
              icon: Icons.mobile_screen_share,
            ),
            ComponentSetting(title: "Logout", icon: Icons.exit_to_app),
          ],
        ),
      ),
    );
  }
}
