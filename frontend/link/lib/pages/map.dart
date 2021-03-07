import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link/components/listtile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  var data;

  MapPage({this.data});
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;

  Completer<GoogleMapController> _controller = Completer();

  // void _setMarkers(LatLng point) {
  //   final String markerIdVal = 'marker_id_$_markerIdCounter';
    

  //   _markers.add(
  //     Marker(
  //       markerId: MarkerId("marker_id_2"),
  //       position: point,
  //       //icon: sourceIcon
  //     ),
  //   );
  // }

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
                  //_setMarkers(LatLng(lat, long));
                  return GoogleMap(
                    myLocationEnabled: true,
         compassEnabled: true,

                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, long),
                      zoom: 13,
                    ),
                    //markers: _markers,
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
                    name: widget.data['data'][0]['name'],
                    userPath: 'assets/images/null.png',
                    online: widget.data['data'][0]['available'],
                    user: true,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.data['data'][0]['friends'].length,
                      itemBuilder: (context, index) {
              
                        return UserTile(
                          name: widget.data['data'][0]['friends'][index]
                              ['friend']['name'],
                          userPath: 'assets/images/null.png',
                          online: widget.data['data'][0]['friends'][index]
                              ['friend']['available'],
                        );
                      })
                ],
              ))
        ],
      ),
    );
  }
}
