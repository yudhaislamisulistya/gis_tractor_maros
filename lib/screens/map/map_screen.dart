import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:thesisgisproject/Screens/Map/Components/once_detail_location.dart';
import 'package:thesisgisproject/blocs/history.dart';
import 'package:thesisgisproject/constants.dart';
import 'package:thesisgisproject/services/geolocator_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  final bool status;
  final double latitude;
  final double longitude;

  MapScreen({this.status, this.latitude, this.longitude});

  @override
  State<StatefulWidget> createState() =>
      _MapScreenState(status, latitude, longitude);
}

class _MapScreenState extends State<MapScreen> {
  bool status;
  double latitude;
  double longitude;

  _MapScreenState(this.status, this.latitude, this.longitude);

  final GeolocatorService geoService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  List<LatLng> routeCoords;
  Set<Marker> _attractionMarkerList = Set();
  Marker currentDestMarker;
  Set<Polyline> _routesPolylines = Set();
  double currentlocationlat;
  double currentlocationlong;
  String to;
  String from;
  String distance;
  String duration;
  bool statusInfoLocation;
  ProgressDialog pr;

  getTractorList() async {
    return await Firestore.instance.collection('tractors').getDocuments();
  }

  @override
  void initState() {
    if (status == true) {
      centerScreen(latitude, longitude);
    } else {
      geoService.getCurrentLocation().listen((position) {
        centerScreen(position.latitude, position.longitude);
        currentlocationlat = position.latitude;
        currentlocationlong = position.longitude;
        print("Lat  : " +
            currentlocationlat.toString() +
            " Long  : " +
            currentlocationlong.toString());
      });
    }
    super.initState();
    getTractorList().then((results) {
      setState(() {
        for (int i = 0; i < results.documents.length; i++) {
          listTractors.add(new Tractor(
              namaKelompokTani: results.documents[i].data["nama_kelompok_tani"],
              namaPemilik: results.documents[i].data["nama_pemilik"],
              alamat: results.documents[i].data["alamat"],
              namaBarang: results.documents[i].data["nama_barang"],
              merek: results.documents[i].data["merek"],
              volume: results.documents[i].data["volume"],
              nomorMesin: results.documents[i].data["nomor_mesin"],
              nomorRangka: results.documents[i].data["nomor_rangka"],
              locationCoords: LatLng(
                  double.parse(results.documents[i].data["latitude"]),
                  double.parse(results.documents[i].data["longitude"])),
              kondisi: results.documents[i].data["kondisi"],
              urlGambar: results.documents[i].data["url_image"]));
        }
      });
    });
    listTractors.forEach(
      (element) {
        allMarkers.add(
          new Marker(
            markerId: new MarkerId(
              element.namaKelompokTani,
            ),
            icon: BitmapDescriptor.defaultMarker,
            draggable: false,
            position: element.locationCoords,
            onTap: () {
              showModalDetailLocation(
                  context,
                  element.namaKelompokTani,
                  element.namaPemilik,
                  element.alamat,
                  element.namaBarang,
                  element.merek,
                  element.volume,
                  element.nomorMesin,
                  element.nomorRangka,
                  element.kondisi,
                  element.locationCoords,
                  element.urlGambar);
            },
          ),
        );
      },
    );
  }

  void showModalDetailLocation(
      context,
      namaKelompokTani,
      namaPemilik,
      alamat,
      namaBarang,
      merek,
      volume,
      nomorMesin,
      nomorRangka,
      kondisi,
      LatLng locationCoords,
      urlGambar) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return new SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        namaKelompokTani,
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
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Jenis : " + namaBarang,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        "Merek : " + merek,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        "Volume : " + volume,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        "Nomor Mesin : " + nomorMesin,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        "Nomor Rangka : " + nomorRangka,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        "Kondisi : " + kondisi,
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  new ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          image: NetworkImage(urlGambar),
                          fit: BoxFit.contain,
                        ),
                      ),
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
                                alamat,
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
                              Icons.people,
                              color: Colors.grey,
                              size: 12,
                            ),
                            new Text(
                              namaPemilik,
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
                      new Container(
                        decoration: new BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: new IconButton(
                          icon: new Icon(
                            Icons.navigation,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            pr.show();
                            _drawRoutesBetweenSourceAndDestination(
                                locationCoords.latitude,
                                locationCoords.longitude);
                            Future.delayed(
                              Duration(
                                seconds: 2,
                              ),
                            ).then(
                              (onValue) {
                                if (pr.isShowing()) {
                                  pr.hide();
                                  Navigator.of(context).pop();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(message: 'Showing some progress...');

    //Optional
    pr.style(
      message: 'Silahkan Tunggu',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return new FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      child: Consumer<Position>(
        builder: (context, position, widget) {
          if (position != null) {
            currentlocationlat = position.latitude;
            currentlocationlong = position.longitude;
          }
          return (position != null)
              ? Scaffold(
                  floatingActionButton: new FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(Icons.navigation),
                    backgroundColor: kPrimaryColor,
                    onPressed: () {
                      geoService.getCurrentLocation().listen(
                        (position) {
                          centerScreen(position.latitude, position.longitude);
                          currentlocationlat = position.latitude;
                          currentlocationlong = position.longitude;
                          print("Lat  : " +
                              currentlocationlat.toString() +
                              " Long  : " +
                              currentlocationlong.toString());
                        },
                      );
                    },
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  appBar: new AppBar(
                    title: new Text("Map Screen"),
                    elevation: 0,
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                  ),
                  body: new Stack(
                    children: <Widget>[
                      _buildGoogleMap(position),
                      statusInfoLocation == true
                          ? OnceDetailLocation(
                              name: "Yudha Islami Sulistya",
                              from: from,
                              to: to,
                              distance: distance,
                              duration: duration,
                            )
                          : new Container(),
                    ],
                  ),
                )
              : new Scaffold(
                  appBar: new AppBar(
                    title: new Text("Map Screen"),
                    elevation: 0,
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                  ),
                  body: new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Container _buildGoogleMap(Position position) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 10.0),
        mapType: MapType.normal,
        markers: Set.from(allMarkers),
        polylines: _routesPolylines,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> centerScreen(latitude, longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 18.0)));
  }

  void _drawRoutesBetweenSourceAndDestination(
      double destLat, double destLong) async {
    String url;

    url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$currentlocationlat,$currentlocationlong&destination=$destLat,$destLong&key=AIzaSyA-osO8lCkbQb_W4KpQ7Y5z9PZIkIUE-M8';

    print('request URL is: $url\n');

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      String routesPolyline =
          parsedJson['routes'][0]['overview_polyline']['points'];

      final coorValues = _decodePoly(routesPolyline);
      List<LatLng> routesPoints = [];
      for (int i = 0; i < coorValues.length; i += 2) {
        routesPoints.add(LatLng(coorValues[i], coorValues[i + 1]));
      }

      final poly = Polyline(
        polylineId: PolylineId(routesPoints.toString()),
        points: routesPoints,
        width: 5,
        color: Colors.indigo,
      );

      final newDestMarker = Marker(
        markerId: MarkerId(
          routesPoints.last.toString(),
        ),
        position:
            LatLng(routesPoints.last.latitude, routesPoints.last.longitude),
        icon: BitmapDescriptor.defaultMarker,
        draggable: false,
      );

      dynamic historyData = {
        "pergi": parsedJson['routes'][0]['legs'][0]['end_address'],
        "dari": parsedJson['routes'][0]['legs'][0]['start_address'],
        "jarak": parsedJson['routes'][0]['legs'][0]['distance']['text'],
        "waktu": parsedJson['routes'][0]['legs'][0]['duration']['text'],
        "created_at": DateTime.now(),
      };

      historyBloc.addDataHistory(historyData);

      setState(() {
        _routesPolylines = [poly].toSet();
        _attractionMarkerList.remove(currentDestMarker);
        _attractionMarkerList.add(newDestMarker);
        currentDestMarker = newDestMarker;
        to = parsedJson['routes'][0]['legs'][0]['end_address'];
        from = parsedJson['routes'][0]['legs'][0]['start_address'];
        distance = parsedJson['routes'][0]['legs'][0]['distance']['text'];
        duration = parsedJson['routes'][0]['legs'][0]['duration']['text'];
        statusInfoLocation = true;
      });
    }
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
}

class Tractor {
  String namaKelompokTani;
  String namaPemilik;
  String alamat;
  String namaBarang;
  String merek;
  String volume;
  String nomorMesin;
  String nomorRangka;
  LatLng locationCoords;
  String kondisi;
  String urlGambar;

  Tractor(
      {this.namaKelompokTani,
      this.namaPemilik,
      this.alamat,
      this.namaBarang,
      this.merek,
      this.volume,
      this.nomorMesin,
      this.nomorRangka,
      this.locationCoords,
      this.kondisi,
      this.urlGambar});
}

final List<Tractor> listTractors = [];
