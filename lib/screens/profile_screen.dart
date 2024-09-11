import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/screens/forgetpassword_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final snapshot = await _firestore
            .collection('User')
            .where('Name', isEqualTo: user.displayName)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          setState(() {
            _userDetails = snapshot.docs.first.data();
            _isLoading = false;
          });
        } else {
          setState(() {
            _userDetails = null;
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error fetching user details: $e');
        setState(() {
          _userDetails = null;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _userDetails = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 4,
        title: Center(
          child: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 30.0,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _userDetails == null
                ? Text('No user details found')
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading:
                                      Icon(Icons.person, color: primaryColor),
                                  title: Text('Name'),
                                  subtitle:
                                      Text('${user?.displayName ?? "N/A"}'),
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.email, color: primaryColor),
                                  title: Text('Email'),
                                  subtitle: Text('${user?.email ?? "N/A"}'),
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.phone, color: primaryColor),
                                  title: Text('Mobile'),
                                  subtitle: Text(
                                      '${_userDetails?['Mobile'] ?? "N/A"}'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text('Reset Password'),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () async {
                                await _auth.signOut();
                                _navigateToLoginPage(context);
                              },
                              child: Text('Sign Out'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
