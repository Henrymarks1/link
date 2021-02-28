import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link/components/listtile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.014797, -118.465112),
    zoom: 13,
  );

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: 10,
                right: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
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
