import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/components/squareButton.dart';
import 'package:smart_code_mentor/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    User? user = _auth.currentUser;
    MainScreen.selectedIndex = 0;
    if (user != null) {
      _navigateToHomePage(context);
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        print("Signed in: ${userCredential.user!.uid}");
        _navigateToHomePage(context);
      } catch (e) {
        print("Error: $e");

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid email or password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _navigateToHomePage(BuildContext context) {
    MainScreen.selectedIndex = 0;
    Navigator.pushNamed(context, '/main');
  }

  void _navigateToSignupPage(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }

  void _navigateForgotPasswordScreen(BuildContext context) {
    Navigator.pushNamed(context, '/forgetpassword');
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align "Login" text to the left
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset('assets/images/login.png', width: 200),
                SizedBox(height: 16.0),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16.0),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: _validatePassword,
                ),
                SizedBox(height: 8.0),


                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _navigateForgotPasswordScreen(context),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Login button
                SquareButton(
                  text: 'Login',
                  size: 82.0,
                  onPressed: () {
                    _signInWithEmailAndPassword(context);
                  },
                ),

                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black, 
                        height: 1, 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                SquareButton(
                  text: 'Sign Up',
                  size: 75.0,
                  onPressed: () {
                    _navigateToSignupPage(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
