import 'package:flutter/material.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/components/squareButton.dart';
import 'package:smart_code_mentor/screens/main_screen.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  late Interpreter _interpreter;
  String _result = '';
  double marks = 0.0;
  String _improvementMessage = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/neural/predmodel.tflite');
      print('Model loaded successfully.');
      await _fetchStudentMarks();
    } catch (e) {
      print('Failed to load the model: $e');
    }
  }

  Future<void> _fetchStudentMarks() async {
    String? userDisplayName = FirebaseAuth.instance.currentUser?.displayName;

    if (userDisplayName == null) {
      print('No user logged in.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('marks')
          .where('studentName', isEqualTo: userDisplayName)
          .get();

      List<double> marks = [];
      for (var doc in snapshot.docs) {
        if (marks.length < 5) {
          marks.add(doc['marks'].toDouble());
        }
      }

      if (marks.length < 5) {
        print('Not enough marks data.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await _runInference(marks);
    } catch (e) {
      print('Error fetching student marks: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _runInference(List<double> input) async {
    var inputData = input;
    var outputData = List<List<double>>.filled(1, List.filled(1, 0.0));

    try {
      _interpreter.run(inputData, outputData);

      setState(() {
        _result = outputData[0][0].toString();
        marks = outputData[0][0] * 10;
        _generateImprovementMessage(double.parse(_result));
        _isLoading = false;
      });
    } catch (e) {
      print('Error during inference: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _generateImprovementMessage(double prediction) {
    String message;
    if (prediction > 8) {
      message = 'Excellent work! Keep up the great effort in Python.';
    } else if (prediction > 6) {
      message = 'Good job! A little more practice and you will master Python.';
    } else if (prediction > 4) {
      message =
          'You are doing well, but consider revisiting some of the basics.';
    } else {
      message =
          'It might be helpful to spend more time on Python fundamentals.';
    }

    setState(() {
      _improvementMessage = message;
    });
  }

  void _navigateToHomePage(BuildContext context) {
    MainScreen.selectedIndex = 0;
    Navigator.pushNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Course Completed',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: textColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: iconColor,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assessment,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Learning Accuracy:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${marks.toStringAsFixed(2)} / 100',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Improvement Message:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _improvementMessage,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SquareButton(
                      text: 'Back to Dashbord',
                      size: 50.0,
                      onPressed: () {
                        _navigateToHomePage(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }
}
