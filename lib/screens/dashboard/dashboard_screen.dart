

import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Dashboard/components/my_header.dart';
import 'package:thesisgisproject/Screens/Dashboard/detail_location_screen.dart';
import 'package:thesisgisproject/Screens/Info/info_screen.dart';
import 'package:thesisgisproject/blocs/tractor.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:thesisgisproject/screens/map/map_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/chat.svg",
              textTop: "GIS Tractor",
              textBottom: "Maros",
              offset: offset,
              status: 1,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Recently Location",
                              style: kTitleTextstyle,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) {
                                return new DetailLocationScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: new StreamBuilder(
                      stream: tractorBloc.fiveTractor,
                      builder: (context, snapshot){
                        if (!snapshot.hasData) {
                          return new Container(
                            child: new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              dynamic data = snapshot.data.documents[index];
                              return SymptomCard(
                                image: "assets/images/add.png",
                                title: data["nama_kelompok_tani"],
                                latitude: double.parse(data["latitude"]),
                                longitude: double.parse(data["longitude"]),
                                isActive: true,
                              );
                            },
                          );
                        }
                      }
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Maps Maros",
                        style: kTitleTextstyle,
                      ),
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) {
                                return new MapScreen(
                                  status: true,
                                  latitude: -4.965086,
                                  longitude: 119.4394441,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
