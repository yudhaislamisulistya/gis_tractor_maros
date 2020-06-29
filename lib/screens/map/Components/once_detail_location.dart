import 'package:flutter/material.dart';
import 'package:thesisgisproject/constants.dart';


class OnceDetailLocation extends StatelessWidget {
  final String name;
  final String to;
  final String from;
  final String distance;
  final String duration;

  OnceDetailLocation({this.name, this.to, this.from, this.distance, this.duration});
  @override
  Widget build(BuildContext context) {
    return new Positioned(
      bottom: 10.0,
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: new Container(
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
                  new Expanded(
                    child: new Text(
                      from,
                      style: new TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  new Expanded(
                    child: new Text(
                      to,
                      style: new TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
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
                    Icons.motorcycle,
                    color: Colors.grey,
                  ),
                  new Text(
                    distance,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  new Text(
                    duration,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
