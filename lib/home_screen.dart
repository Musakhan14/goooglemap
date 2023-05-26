// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
// //   In the context of the Google Maps Flutter package, the GoogleMapController is used to interact with the Google Maps widget. It provides methods and properties to control and manipulate the map, such as zooming, panning, adding markers, and more.
// // By creating a Completer<GoogleMapController>, you are setting up a mechanism to obtain an instance of GoogleMapController in the future. Once the GoogleMapController instance is ready, you can complete the Completer by calling its complete method with the desired value.
//   final Completer<GoogleMapController> _controller = Completer();
//   static const CameraPosition _kgooglePlex =
//       CameraPosition(target: LatLng(34.8674571, 71.8780826), zoom: 14.4746);
//   final List<Marker> _marker =
//       []; //marker id use to view the selected LatLng position
//   final List<Marker> _list = const [
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(34.8674571, 71.8780826),
//         infoWindow: InfoWindow(
//           title: 'My Location',
//         )),
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(34.856487, 71.855337),
//         infoWindow: InfoWindow(
//           title: 'Home',
//         )),
//     Marker(
//         markerId: MarkerId('2'),
//         position: LatLng(34.003540, 72.042558),
//         infoWindow: InfoWindow(
//           title: 'Dheri Katti Khel, Nowshera, Khyber Pakhtunkhwa, Pakistan',
//         )),
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _marker.addAll(_list);
//   }

// // List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
//   String address1 = '';
//   String longLan = '';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: const Text('Google Map'),
//           ),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(address1),
//               Text(longLan.toString()),
//               InkWell(
//                 //Get address from coordinates and coordinates from address
//                 onTap: () async {
//                   List<Location> locations =
//                       await locationFromAddress("Gronausestraat 710, Enschede");
//                   Location location = locations[0];
//                   if (kDebugMode) {
//                     print(
//                         'Lang ${location.latitude} Long ${location.longitude}');
//                   }
//                   List<Placemark> placemarks = await placemarkFromCoordinates(
//                       52.216515699999995, 6.9459706);
//                   if (placemarks.isNotEmpty) {
//                     Placemark placemark = placemarks[0];
//                     String address =
//                         '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country},${placemark.subLocality}';
//                     if (kDebugMode) {
//                       print(address);
//                     }
//                     setState(() {
//                       address1 = address;
//                       longLan =
//                           'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
//                     });
//                   }
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 50,
//                     decoration: const BoxDecoration(
//                       color: Colors.blueGrey,
//                     ),
//                     child: const Center(child: Text('Convert')),
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   In the context of the Google Maps Flutter package, the GoogleMapController is used to interact with the Google Maps widget. It provides methods and properties to control and manipulate the map, such as zooming, panning, adding markers, and more.
// By creating a Completer<GoogleMapController>, you are setting up a mechanism to obtain an instance of GoogleMapController in the future. Once the GoogleMapController instance is ready, you can complete the Completer by calling its complete method with the desired value.
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kgooglePlex =
      CameraPosition(target: LatLng(34.8674571, 71.8780826), zoom: 14.4746);
  final List<Marker> _marker =
      []; //marker id use to view the selected LatLng position
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(34.8674571, 71.8780826),
        infoWindow: InfoWindow(
          title: 'My Location',
        )),
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(34.856487, 71.855337),
    //     infoWindow: InfoWindow(
    //       title: 'Home',
    //     )),
    // Marker(
    //     markerId: MarkerId('2'),
    //     position: LatLng(34.003540, 72.042558),
    //     infoWindow: InfoWindow(
    //       title: 'Dheri Katti Khel, Nowshera, Khyber Pakhtunkhwa, Pakistan',
    //     )),
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
      print('error$error');
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
          // myLocationEnabled: true,
          // compassEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            getUserCurrentLocation().then((value) async {
              print('my location');
              print(
                value.latitude.toString() + " " + value.longitude.toString(),
              );
            });
          },
          child: const Icon(Icons.location_disabled_outlined),
        ),
      ),
    );
  }
}
