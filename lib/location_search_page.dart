import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _filteredUsers = [];

  void _searchLocations() {
    String query = _searchController.text.toLowerCase();
    FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      List<QueryDocumentSnapshot> users = snapshot.docs.where((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String locationName = data['locationName']?.toLowerCase() ?? '';
        return locationName.contains(query);
      }).toList();

      setState(() {
        _filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Locations'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Location',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchLocations,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<QueryDocumentSnapshot> users = _filteredUsers.isNotEmpty ? _filteredUsers : snapshot.data!.docs;

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
                      markers: users.map((user) {
                        Map<String, dynamic> data = user.data() as Map<String, dynamic>;
                        var location = data['location'];
                        return Marker(
                          point: LatLng(location['latitude'], location['longitude']),
                          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
