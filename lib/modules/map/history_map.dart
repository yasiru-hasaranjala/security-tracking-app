import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryMap extends StatefulWidget {
  const HistoryMap({super.key});

  @override
  State<HistoryMap> createState() => HistoryMapState();
}

class HistoryMapState extends State<HistoryMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final ref = FirebaseDatabase.instance.ref();
  Set<Marker> markers = {};

  void initState() {
    super.initState();
  }

  void getLocations(snap) async {
    final latLng1 = await LatLng(
        double.parse(snap.data!.snapshot.child('l1').child('Latitude').value.toString()),
        double.parse(snap.data!.snapshot.child('l1').child('Longitude').value.toString())
    );

    final latLng2 = await LatLng(
        double.parse(snap.data!.snapshot.child('l2').child("Latitude").value.toString()),
        double.parse(snap.data!.snapshot.child('l2').child("Longitude").value.toString())
    );

    final latLng3 =  await LatLng(
        double.parse(snap.data!.snapshot.child('l3').child("Latitude").value.toString()),
        double.parse(snap.data!.snapshot.child('l3').child("Longitude").value.toString())
    );

    await markers.add(Marker(markerId: const MarkerId("1"), position: latLng1));
    await markers.add(Marker(markerId: const MarkerId("2"), position: latLng2));
    await markers.add(Marker(markerId: const MarkerId("3"), position: latLng3));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Scaffold(
        body: StreamBuilder(
          stream: ref.child('History').onValue,
          builder: (context, snap) {
            if (snap.hasError) {
              return Text('Something went wrong');
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            double lat = double.parse(snap.data!.snapshot.child('l1').child('Latitude').value.toString());
            double long = double.parse(snap.data!.snapshot.child('l1').child('Longitude').value.toString());

            final latLng1 = LatLng(
                double.parse(snap.data!.snapshot.child('l1').child('Latitude').value.toString()),
                double.parse(snap.data!.snapshot.child('l1').child('Longitude').value.toString())
            );

            final latLng2 = LatLng(
                double.parse(snap.data!.snapshot.child('l2').child("Latitude").value.toString()),
                double.parse(snap.data!.snapshot.child('l2').child("Longitude").value.toString())
            );

            final latLng3 =  LatLng(
                double.parse(snap.data!.snapshot.child('l3').child("Latitude").value.toString()),
                double.parse(snap.data!.snapshot.child('l3').child("Longitude").value.toString())
            );

            markers.add(Marker(markerId: const MarkerId("1"), position: latLng1));
            markers.add(Marker(markerId: const MarkerId("2"), position: latLng2));
            markers.add(Marker(markerId: const MarkerId("3"), position: latLng3));


            // If google map is already created then update camera position with animation
            // final GoogleMapController mapController = await _controller.future;
            // mapController.animateCamera(CameraUpdate.newCameraPosition(
            //   CameraPosition(
            //     target: latLng,
            //     zoom: 15.8746,
            //   ),
            // ));

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, long),
                zoom: 12.1746,
              ),

              // Markers to be pointed
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                // Assign the controller value to use it later
                _controller.complete(controller);
              },
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.white,

              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Location History'),
        ),
      ),
    );
  }
}