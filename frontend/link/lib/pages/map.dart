import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              panel: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/images/henry.JPG',
                  ),
                ),
                title: const Text("Henry Marks"),
                subtitle: const Text('Online.'),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  size: 35,
                ),
              )),
        ],
      ),
    );
  }
}
