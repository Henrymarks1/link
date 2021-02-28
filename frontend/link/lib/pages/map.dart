import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link/components/listtile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;

  Completer<GoogleMapController> _controller = Completer();

  List<Map> friends = [
    {
      "available": false,
      "name": "Jason Telenoff",
      "image_path": "assets/images/jason.png"
    },
    {
      "available": true,
      "name": "Ethan Hopkins",
      "image_path": "assets/images/ethan.jpg"
    },
    {
      "available": true,
      "name": "Ben Swerdlow",
      "image_path": "assets/images/swerd.jpg"
    },
    {
      "available": false,
      "name": "Jacob Zwang",
      "image_path": "assets/images/jacob.jpg"
    }
  ];
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;

    _markers.add(
      Marker(
        markerId: MarkerId(markerIdVal),
        position: point,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: Geolocator.getPositionStream(
                  desiredAccuracy: LocationAccuracy.best),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return new Text("Error!");
                } else if (asyncSnapshot.data == null) {
                  return Text("no location");
                } else {
                  List data = asyncSnapshot.data
                      .toString()
                      .split(':')
                      .join(',')
                      .split(',');
                  double lat = double.parse(data[1]);
                  double long = double.parse(data[3]);
                  _setMarkers(LatLng(lat, long));
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, long),
                      zoom: 13,
                    ),
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  );
                }
              }),
          SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              panel: Column(
                children: [
                  UserTile(
                    name: "Henry Marks",
                    userPath: 'assets/images/henry.JPG',
                    online: true,
                    user: true,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          name: friends[index]['name'],
                          userPath: friends[index]['image_path'],
                          online: friends[index]['available'],
                        );
                      })
                ],
              ))
        ],
      ),
    );
  }
}
