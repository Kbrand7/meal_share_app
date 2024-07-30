import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'browse_donations_page.dart';
import 'donations_alerts_page.dart';
import 'recipient_profile_page.dart';
import 'location_search_page.dart';
import 'pickup_locations_page.dart';
import 'pickup_scheduling_page.dart';
import 'status_updates_page.dart';
import 'volunteer_coordination_page.dart';
import 'login_page.dart'; // Ensure you have a login page to redirect to

class RecipientHomePage extends StatelessWidget {
  final String username;

  RecipientHomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'HI RECIEVERWELCOME TO MEAL SHARE APP',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'IMPACT STORIES',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'FOOD RESCUE',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrowseDonationsPage()),
                      );
                    },
                    label: 'Browse Donations',
                    iconPath: 'assets/images/browse_donations.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonationsAlertsPage()),
                      );
                    },
                    label: 'Donation Alerts',
                    iconPath: 'assets/images/alerts.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LocationSearchPage()),
                      );
                    },
                    label: 'Location-Based Search',
                    iconPath: 'assets/images/location.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PickupLocationsPage()),
                      );
                    },
                    label: 'Pickup Locations',
                    iconPath: 'assets/images/pick_location.png', // Removed icon
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatusUpdatesPage()),
                      );
                    },
                    label: 'Status Updates',
                    iconPath: 'assets/images/status_updates.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PickupSchedulingPage()),
                      );
                    },
                    label: 'Pickup Scheduling',
                    iconPath: 'assets/images/pickup_scheduling.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VolunteerCoordinationPage()),
                      );
                    },
                    label: 'Volunteer Coordination',
                    iconPath: 'assets/images/volunteer_coordination.png',
                  ),
                  SizedBox(height: 20.0),
                  CustomHoverButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipientProfilePage()),
                      );
                    },
                    label: 'Recipient Profile',
                    iconPath: 'assets/images/profile.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/browse_donations.png', width: 24, height: 24),
              title: Text('Browse Donations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseDonationsPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/alerts.png', width: 24, height: 24),
              title: Text('Donation Alerts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationsAlertsPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/location.png', width: 24, height: 24),
              title: Text('Location-Based Search'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationSearchPage()),
                );
              },
            ),
            ListTile(
              title: Text('Pickup Locations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickupLocationsPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/status_updates.png', width: 24, height: 24),
              title: Text('Status Updates'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusUpdatesPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/pickup_scheduling.png', width: 24, height: 24),
              title: Text('Pickup Scheduling'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickupSchedulingPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/volunteer_coordination.png', width: 24, height: 24),
              title: Text('Volunteer Coordination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VolunteerCoordinationPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/profile.png', width: 24, height: 24),
              title: Text('Recipient Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipientProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/logout.png', width: 24, height: 24),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to your login page
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHoverButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String iconPath;

  const CustomHoverButton({
    required this.onPressed,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconPath, width: 50, height: 50),
            SizedBox(height: 10.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
