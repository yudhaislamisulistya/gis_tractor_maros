import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thesisgisproject/Screens/Map/Components/button_detail_location.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:thesisgisproject/services/geolocator_service.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GeolocatorService geoService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  List<LatLng> routeCoords;



  getaddressPoints() async {
  }

  @override
  void initState() {
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
    coffeShops.forEach(
          (element) {
        allMarkers.add(
          new Marker(
            markerId: new MarkerId(
              element.shopName,
            ),
            icon: BitmapDescriptor.defaultMarker,
            draggable: false,
            position: element.locationCoords,
            onTap: () {
              showModalDetailLocation(context);
            },
          ),
        );
      },
    );
  }

  void showModalDetailLocation(context) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: const EdgeInsets.all(12.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: MediaQuery.of(context).size.height * .40,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Lokasi GIS Tractor Maros 1",
                      style: kTitleTextstyle,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                new Divider(),
                new ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage("assets/images/bg.jpg"),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                new SizedBox(
                  height: 5.0,
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.assistant_photo,
                            color: Colors.grey,
                            size: 12,
                          ),
                          new Expanded(
                            child: new Text(
                              "Jl. Pulau Papan No. 32 (Kompleks Kabaka)",
                              style: new TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Flexible(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 12,
                          ),
                          new Text(
                            "+6285340472927",
                            style:
                            new TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonDetailLocation(
                      icon: Icons.navigation,
                      color: kPrimaryColor,
                    ),
                    ButtonDetailLocation(
                      icon: Icons.call_end,
                      color: Colors.deepOrange,
                    ),
                    ButtonDetailLocation(
                      icon: Icons.call,
                      color: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      child: Consumer<Position>(
        builder: (context, position, widget) {
          return (position != null)
              ? Scaffold(
            appBar: new AppBar(
              title: new Text("Map Screen"),
              elevation: 0,
              backgroundColor: kPrimaryColor,
              centerTitle: true,
            ),
            body: Center(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 10.0),
                mapType: MapType.normal,
                myLocationEnabled: true,
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          )
              : new Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }
}

class Coffee {
  String shopName;
  String address;
  String description;
  String thumbnail;
  LatLng locationCoords;

  Coffee(
      {this.shopName,
        this.address,
        this.description,
        this.thumbnail,
        this.locationCoords});
}

final List<Coffee> coffeShops = [
  Coffee(
    shopName: "Lentera Lipuku Sekretariat",
    address: "Jl. Nusantara (Kompleks Kabaka)",
    description: "Sekretariat Lentera Lipuku",
    locationCoords: LatLng(-0.871517, 121.585705),
    thumbnail: "assets/images/gambar1.jpg",
  ),
  Coffee(
    shopName: "Mpoa Lipu",
    address: "Vananga Bulan",
    description: "Kegiatan Lentera Lipuku Chapter 1.0",
    locationCoords: LatLng(-1.299292, 121.978819),
    thumbnail: "assets/images/gambar1.jpg",
  ),
  Coffee(
    shopName: "Takibangke",
    address: "Takibangke, Ulubongka, Tojo Una-Una Regency",
    description: "Kegiatan Lentera Lipuku Chapter 2.0",
    locationCoords: LatLng(-1.131029, 121.540278),
    thumbnail: "assets/images/gambar1.jpg",
  )
];
