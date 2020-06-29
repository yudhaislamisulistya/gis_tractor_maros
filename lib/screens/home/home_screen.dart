import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/History/history_screen.dart';
import 'package:thesisgisproject/Screens/Inbox/inbox_screen.dart';
import 'package:thesisgisproject/Screens/Profile/profile_screen.dart';
import 'file:///C:/Android/thesis_gis_project/lib/Screens/Dashboard/dashboard_screen.dart';
import 'package:thesisgisproject/constants.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  HomeScreen({this.email});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Color colorIconHome;
  Color colorIconHistory;
  Color colorIconInbox;
  Color colorIconProfile;
  @override
  void initState() {
    this.colorIconHome = Colors.white;
    this.colorIconHistory = kPrimaryColor;
    this.colorIconInbox = kPrimaryColor;
    this.colorIconProfile = kPrimaryColor;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: colorIconHome,
          ),
          Icon(
            Icons.history,
            size: 30,
            color: colorIconHistory,
          ),
          Icon(
            Icons.inbox,
            size: 30,
            color: colorIconInbox,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: colorIconProfile,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: kPrimaryLightColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            if(index == 0){
              colorIconHome = Colors.white;
              colorIconHistory = colorIconInbox = colorIconProfile = kPrimaryColor;
            }else if(index == 1){
              colorIconHistory = Colors.white;
              colorIconHome = colorIconInbox = colorIconProfile = kPrimaryColor;
            }else if(index == 2){
              colorIconInbox = Colors.white;
              colorIconHome = colorIconHistory = colorIconProfile = kPrimaryColor;
            }else if(index == 3){
              colorIconProfile = Colors.white;
              colorIconHome = colorIconInbox = colorIconHistory = kPrimaryColor;
            }
          });
        },
      ),
      body: buildContainer(),
    );
  }

  buildContainer() {
    if (_page == 0) {
      return new DashboardScreen();
    } else if (_page == 1) {
      return new HistoryScreen(email: widget.email,);
    } else if (_page == 2) {
      return new InboxScreen();
    } else if (_page == 3) {
      return new ProfileScreen(email: widget.email,);
    }
  }
}
