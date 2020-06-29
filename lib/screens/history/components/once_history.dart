import 'package:flutter/material.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:intl/intl.dart';


class OnceHistoty extends StatelessWidget {
  final String name;
  final String to;
  final String from;
  final String datetime;

  OnceHistoty({this.name, this.to, this.from, this.datetime});


  @override
  Widget build(BuildContext context) {
    return new Container(
      margin:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      width: 35,
                      height: 35,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: AssetImage("assets/images/man-avatar.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new Text(
                      name,
                      style: kTitleTextstyle,
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Container(
                      width: 35,
                      height: 35,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image:
                          AssetImage("assets/images/compass.png"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            new Divider(),
            new Row(
              children: <Widget>[
                new Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                new Flexible(
                  child: new RichText(
                    overflow: TextOverflow.fade,
                    text: new TextSpan(
                      text: from,
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            new Row(
              children: <Widget>[
                new Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
                new Flexible(
                  child: new RichText(
                    overflow: TextOverflow.fade,
                    text: new TextSpan(
                      text: to,
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Icon(
                  Icons.access_time,
                  color: Colors.grey,
                ),
                new Flexible(
                  child: new RichText(
                    overflow: TextOverflow.fade,
                    text: new TextSpan(
                      text: readTimestamp(int.parse(datetime.substring(18, 28))),
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}


