import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Dashboard/components/my_header.dart';
import 'package:thesisgisproject/Screens/History/components/once_history.dart';
import 'package:thesisgisproject/blocs/history.dart';
import 'package:thesisgisproject/constants.dart';

class HistoryScreen extends StatefulWidget {
  final String email;
  HistoryScreen({this.email});
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/history.svg",
              textTop: "GIS Tractor",
              textBottom: "History",
              offset: offset,
            ),

            new StreamBuilder(
              stream: historyBloc.allHistories,
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
                      return new OnceHistoty(
                        name: widget.email,
                        from: data["dari"],
                        to: data["pergi"],
                        datetime: data["created_at"].toString(),
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
