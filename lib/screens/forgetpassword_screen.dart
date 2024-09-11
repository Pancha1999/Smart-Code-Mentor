import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_code_mentor/components/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSubmitting = false;
  String _statusMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _statusMessage = '';
      });

      try {
        final String email = _emailController.text;
        await _auth.sendPasswordResetEmail(email: email);

        setState(() {
          _statusMessage = 'Password reset email sent to $email';
        });
      } catch (e) {
        setState(() {
          _statusMessage = 'Failed to send password reset email';
        });
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: primaryColor),
        title: Center(
          child: Row(
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 25.0,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8),
              Image.asset('assets/images/fogo.png', width: 200, height: 200,),
              SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  minimumSize: Size(150, 50),
                ),
                onPressed: _isSubmitting ? null : _resetPassword,
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
              ),
              SizedBox(height: 16.0),
              Text(_statusMessage),
            ],
          ),
        ),
      ),
    );
  }
}
