import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final ref = FirebaseDatabase.instance.ref();
  Set<Marker> markers = {};

  Set<Marker> markersH = {};

  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  bool doorLock = false;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Scaffold(
        body: StreamBuilder(
          stream: ref.child('Location').onValue,
          builder: (context, snap) {
            if (snap.hasError) {
              return Text('Something went wrong');
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            double lat = double.parse(snap.data!.snapshot.child("Latitude").value.toString());
            double long = double.parse(snap.data!.snapshot.child("Longitude").value.toString());

            final latLng = LatLng(double.parse(snap.data!.snapshot.child("Latitude").value.toString()), double.parse(snap.data!.snapshot.child("Longitude").value.toString()));

            // Add new marker with markerId.
            markers.add(Marker(markerId: const MarkerId("Location"), position: latLng));



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
                zoom: 15.8746,
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
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                backgroundColor: Colors.brown,
                onPressed: (){
                  Navigator.pushNamed(context, 'history_screen');
                },
                label: const Text('History'),
                icon: const Icon(Icons.edit_location),
              ),
            ),
            StreamBuilder(
              stream: ref.child('door_rfid_pir_state').onValue,
              builder: (context, snap) {
                if (snap.hasError) {
                  return const Text('Something went wrong');
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                String door = snap.data!.snapshot.child("door").value.toString();

                return Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    backgroundColor: Colors.amber,
                    onPressed: (){
                        ref.child('door_rfid_pir_state').update(
                          door=='0' ? {"door": 1} : {"door": 0}
                        );
                    },
                    label: door=='0'
                        ? const Text('Door Lock',)
                        : const Text('Door Unlock'),
                    icon: const Icon(Icons.lock_clock),
                  ),
                );
              }
            ),
          ],
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
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
          title: const Text('Security Tracking App'),
        ),
      ),
    );
  }
}