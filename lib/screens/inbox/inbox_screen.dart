import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Dashboard/components/my_header.dart';
import 'package:thesisgisproject/Screens/Info/info_screen.dart';
import 'package:thesisgisproject/blocs/information.dart';
import 'package:thesisgisproject/constants.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
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
    return new Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/inbox.svg",
              textTop: "GIS Tractor",
              textBottom: "Inbox",
              offset: offset,
            ),
            new StreamBuilder(
              stream: informationBloc.allInformations,
              builder: (context, snapshot){
                if (!snapshot.hasData) {
                  return new Container(
                    child: new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return new ListView.builder(
                    controller: controller,
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      dynamic data = snapshot.data.documents[index];
                      return new PreventCard(
                        title: data["judul"],
                        text: data["konten"] + " Per Tanggal " + data["created_at"],
                        image: "assets/images/notification.png",
                      );
                    },
                  );
                }
              },
            )

          ],
        ),
      ),
    );
  }
}
