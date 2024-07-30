import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _email = '';
  String _password = '';
  String _username = '';
  String _userType = 'Recipient';
  String _donorType = 'Restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register to MealShare',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.7),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 48, 31, 31)),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.7),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.7),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                      ),
                      SizedBox(height: 10.0),
                      DropdownButtonFormField<String>(
                        value: _userType,
                        decoration: InputDecoration(
                          labelText: 'User Type',
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 228, 222, 222)),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>['Donor', 'Recipient']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _userType = newValue!;
                          });
                        },
                        onSaved: (newValue) {
                          _userType = newValue!;
                        },
                        style: TextStyle(color: Color.fromARGB(255, 135, 212, 141)),
                      ),
                      if (_userType == 'Donor') ...[
                        SizedBox(height: 10.0),
                        DropdownButtonFormField<String>(
                          value: _donorType,
                          decoration: InputDecoration(
                            labelText: 'Donor Type',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.7),
                            border: OutlineInputBorder(),
                          ),
                          items: <String>[
                            'Restaurant',
                            'Supermarket',
                            'Individual'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _donorType = newValue!;
                            });
                          },
                          onSaved: (newValue) {
                            _donorType = newValue!;
                          },
                          style: TextStyle(color: Color.fromARGB(255, 165, 227, 179)),
                        ),
                      ],
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _register,
                        child: Text('Register'),
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Already have an account? Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        // Save additional user info like userType and donorType if necessary
        // You can use Firebase Firestore for this
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _username,
          'userType': _userType,
          'donorType': _userType == 'Donor' ? _donorType : null,
        });

        // Navigate to login page upon successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        // Handle errors
        print(e.message);
        // Show error message to user if necessary
      }
    }
  }
}
