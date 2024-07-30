import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PostDonationPage extends StatefulWidget {
  @override
  _PostDonationPageState createState() => _PostDonationPageState();
}

class _PostDonationPageState extends State<PostDonationPage> {
  final _formKey = GlobalKey<FormState>();
  String foodType = '';
  int quantity = 0;
  DateTime expirationDate = DateTime.now();
  LatLng? pickupLocation;

  void _postDonation() async {
    if (_formKey.currentState!.validate() && pickupLocation != null) {
      _formKey.currentState?.save();
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('donations').add({
        'donorId': user?.uid,
        'donorName': user?.displayName, // Add the donor's name
        'foodType': foodType,
        'quantity': quantity,
        'expirationDate': expirationDate,
        'pickupLocation': {
          'latitude': pickupLocation!.latitude,
          'longitude': pickupLocation!.longitude,
        },
        'timestamp': Timestamp.now(),
      });

      // Notify recipients
      var recipients = await FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'recipient').get();
      for (var recipient in recipients.docs) {
        FirebaseFirestore.instance.collection('notifications').add({
          'recipientId': recipient.id,
          'message': 'New donation posted: $foodType',
          'timestamp': Timestamp.now(),
        });
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Food Type'),
                  onSaved: (value) => foodType = value!,
                  validator: (value) => value!.isEmpty ? 'Please enter a food type' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => quantity = int.tryParse(value!) ?? 0,
                  validator: (value) => value!.isEmpty || int.tryParse(value) == null ? 'Please enter a valid quantity' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Expiration Date (YYYY-MM-DD)'),
                  onSaved: (value) => expirationDate = DateFormat('yyyy-MM-dd').parse(value!),
                  validator: (value) {
                    try {
                      DateFormat('yyyy-MM-dd').parse(value!);
                      return null;
                    } catch (e) {
                      return 'Please enter a valid date';
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text('Pickup Location:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    var location = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
                    if (location != null) {
                      setState(() {
                        pickupLocation = location;
                      });
                    }
                  },
                  child: const Text('Select Pickup Location'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _postDonation,
                  child: const Text('Post Donation'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng selectedLocation = LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          minZoom: 2.0,
          onTap: (tapPosition, point) {
            setState(() {
              selectedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: selectedLocation,
                child: const Icon(Icons.location_on, color: Colors.blue, size: 40.0),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedLocation);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
