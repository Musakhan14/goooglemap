import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GetUserCurrenLocationScreen extends StatefulWidget {
  const GetUserCurrenLocationScreen({super.key});

  @override
  State<GetUserCurrenLocationScreen> createState() =>
      _GetUserCurrenLocationScreenState();
}

class _GetUserCurrenLocationScreenState
    extends State<GetUserCurrenLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kgooglePlex =
      CameraPosition(target: LatLng(34.8674571, 71.8780826), zoom: 14.4746);
  final List<Marker> _marker =
      []; //marker id use to view the selected LatLng position
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(34.003540, 72.042558),
        infoWindow: InfoWindow(
          title: 'Dheri Katti Khel, Nowshera, Khyber Pakhtunkhwa, Pakistan',
        )),
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _marker.addAll(_list);
  // }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print('error$error');
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kgooglePlex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getUserCurrentLocation().then((value) {
              print(value.altitude);
            });
          },
          child: const Icon(Icons.location_disabled_outlined),
        ),
      ),
    );
  }
}

//geolocator is use for get current location

  // You have to past this to AndroidMainifest.xml file these permession  for android
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
//     <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
//     <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />


  // You have to past this to info.plist file these permession  for ios 

// <key>NSLocationAlwaysAndWhenInUsageDescription</key>
// 	<string>App app want's to access your location to get address</string>
// 	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
// 	<string>App app want's to access your location to get address.</string>
// 	<key>NSLocationAlwaysUsageDescription</key>
// 	<string>App app want's to access your location to get address.</string>
// 	<key>NSLocationWhenInUseUsageDescription</key>
// 	<string> App want's to access your location to get address.</string>