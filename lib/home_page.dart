import 'package:flutter/material.dart';
import 'post_donation_page.dart';
import 'browse_donations_page.dart';
import 'login_page.dart';
import 'location_search_page.dart';
import 'pickup_locations_page.dart';
import 'donations_alerts_page.dart';
import 'status_updates_page.dart';
import 'pickup_scheduling_page.dart';
import 'volunteer_coordination_page.dart';
import 'donor_profile_page.dart';
import 'recipient_profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
                          'WELCOME TO MEAL_SHARE_APP',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'IMPACT_STORIES',
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
                        MaterialPageRoute(builder: (context) => PostDonationPage()),
                      );
                    },
                    label: 'Post Donations',
                    iconPath: 'assets/images/post_donation.png',
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
                    iconPath: '', // Removed icon
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
                    iconPath: '', // Removed icon
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
                        MaterialPageRoute(builder: (context) => DonorProfilePage()),
                      );
                    },
                    label: 'Donor Profile',
                    iconPath: 'assets/images/profile.png',
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
              leading: Image.asset('assets/images/post_donation.png', width: 24, height: 24),
              title: Text('Post Donations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostDonationPage()),
                );
              },
            ),
            ListTile(
              title: Text('Browse Donations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseDonationsPage()),
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
              title: Text('Donor Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorProfilePage()),
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
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final String iconPath;

  const CustomHoverButton({Key? key, required this.onPressed, required this.label, this.iconPath = ''}) : super(key: key);

  @override
  _CustomHoverButtonState createState() => _CustomHoverButtonState();
}

class _CustomHoverButtonState extends State<CustomHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: _isHovered ? Colors.black.withOpacity(0.8) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _isHovered ? Colors.white : Colors.black.withOpacity(0.8),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              _isHovered ? Colors.black.withOpacity(0.8) : Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          icon: widget.iconPath.isNotEmpty 
              ? Image.asset(widget.iconPath, width: 24, height: 24) 
              : Container(),
          label: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
