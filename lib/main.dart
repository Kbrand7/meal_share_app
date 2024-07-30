import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'forgot_password_page.dart';
import 'donor_home_page.dart';
import 'recipient_home_page.dart';
import 'notifications_service.dart';
import 'donations_alerts_page.dart';
import 'status_updates_page.dart';
import 'pickup_scheduling_page.dart';
import 'volunteer_coordination_page.dart';
import 'donor_profile_page.dart';
import 'recipient_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationsService().initialize();
  runApp(MealShareApp());
}

class MealShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Share App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/donor_home': (context) => DonorHomePage(username: ModalRoute.of(context)?.settings.arguments as String),
        '/recipient_home': (context) => RecipientHomePage(username: ModalRoute.of(context)?.settings.arguments as String),
        '/alerts': (context) => DonationsAlertsPage(),
        '/status_updates': (context) => StatusUpdatesPage(),
        '/pickup_scheduling': (context) => PickupSchedulingPage(),
        '/volunteer_coordination': (context) => VolunteerCoordinationPage(),
        '/donor_profile': (context) => DonorProfilePage(),
        '/recipient_profile': (context) => RecipientProfilePage(),
      },
    );
  }
}
