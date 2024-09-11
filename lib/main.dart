import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/screens/forgetpassword_screen.dart';
import 'package:smart_code_mentor/screens/login_screen.dart';
import 'package:smart_code_mentor/screens/main_screen.dart';
import 'package:smart_code_mentor/screens/signup_screen.dart';
import 'package:smart_code_mentor/screens/welcome_screen.dart';

//main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp();
  runApp(MobileApp());
}

// Future initialization(BuildContext? context) async {
//   await Future.delayed(Duration(seconds: 2));
// }

class MobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SNT Traders Admin App',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/forgetpassword': (context) => ForgotPasswordScreen(),
      },
      home: WelcomeScreen(),
    );
  }
}
