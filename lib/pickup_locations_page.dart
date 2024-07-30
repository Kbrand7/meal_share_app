import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PickupLocationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup Locations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var donations = snapshot.data?.docs;

          return FlutterMap(
            options: MapOptions(
              minZoom: 2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: donations?.map((donation) {
                  var location = donation['pickupLocation'];
                  return Marker(
                    point: LatLng(location['latitude'], location['longitude']),
                    child: const Icon(Icons.location_on, color: Colors.blue, size: 40.0),
                  );
                }).toList() ?? [],
              ),
            ],
          );
        },
      ),
    );
  }
}
