import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PickupSchedulingPage extends StatefulWidget {
  @override
  _PickupSchedulingPageState createState() => _PickupSchedulingPageState();
}

class _PickupSchedulingPageState extends State<PickupSchedulingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late String _donationId;

  void _schedulePickup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('pickups').add({
        'donationId': _donationId,
        'scheduledDate': Timestamp.fromDate(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        )),
        'volunteerId': user?.uid,
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pickup scheduled')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Pickup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('donations').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var donations = snapshot.data?.docs;

                  return DropdownButtonFormField(
                    items: donations?.map((donation) {
                      return DropdownMenuItem(
                        value: donation.id,
                        child: Text(donation['foodType']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _donationId = value!),
                    onSaved: (value) => _donationId = value!,
                    validator: (value) => value == null ? 'Please select a donation' : null,
                    decoration: InputDecoration(labelText: 'Donation'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() => _selectedDate = pickedDate);
                  }
                },
                // ignore: unnecessary_null_comparison
                child: Text(_selectedDate == null ? 'Select Date' : _selectedDate.toString()),
              ),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() => _selectedTime = pickedTime);
                  }
                },
                // ignore: unnecessary_null_comparison
                child: Text(_selectedTime == null ? 'Select Time' : _selectedTime.format(context)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _schedulePickup,
                child: Text('Schedule Pickup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
