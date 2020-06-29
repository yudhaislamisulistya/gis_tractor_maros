import 'package:flutter/material.dart';
import 'package:thesisgisproject/Screens/Map/map_screen.dart';
import 'package:thesisgisproject/blocs/tractor.dart';
import 'package:thesisgisproject/constants.dart';

class DetailLocationScreen extends StatefulWidget {
  @override
  _DetailLocationScreenState createState() => _DetailLocationScreenState();
}

class _DetailLocationScreenState extends State<DetailLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: new AppBar(
        title: new Text("Detail Location"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: new Container(
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: new StreamBuilder(
              stream: tractorBloc.allTractors,
              builder: (context, snapshot) {
                print(snapshot.data.documents.length);
                if (!snapshot.hasData) {
                  return new Container();
                } else {
                  return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      dynamic data = snapshot.data.documents[index];
                      return _listTileLocation(data);
                    },
                  );
                }
              })),
    );
  }

  Widget _listTileLocation(data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new ListTile(
        leading: new Icon(
          Icons.add_location,
          color: Colors.green,
        ),
        title: new Text(
          data["nama_kelompok_tani"],
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: new Text(
          "Ditambahkan ${data["created_at"]}",
          style: new TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: new IconButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new MapScreen(
                    status: true,
                    latitude: double.parse(data["latitude"]),
                    longitude: double.parse(data["longitude"]),
                  );
                },
              ),
            );
          },
          icon: new Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}
