import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/components/roundButton.dart';
import 'package:smart_code_mentor/screens/login_screen.dart';
import 'package:smart_code_mentor/screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _navigateToHomePage();
    }
  }

void _navigateToHomePage() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      MainScreen.selectedIndex = 0;
      Navigator.pushReplacementNamed(context, '/main');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 4,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30.0,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                "assets/images/Smart Code Mentor png.png",
                width: 250.0, 
                height: 250.0, 
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to Smart Code Mentor your personalized learning companion for mastering programming with interactive tutorials and real-time progress tracking',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            RoundButton(
              text: 'GET START',
              width: 200,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
