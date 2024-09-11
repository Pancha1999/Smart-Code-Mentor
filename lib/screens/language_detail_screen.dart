import 'package:flutter/material.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/components/squareButton.dart';
import 'package:smart_code_mentor/screens/lessons/lesson_screen_01.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_code_mentor/screens/prediction_screen.dart';

class LanguageDetailScreen extends StatefulWidget {
  final String language;

  LanguageDetailScreen({super.key, required this.language});

  @override
  _LanguageDetailScreenState createState() => _LanguageDetailScreenState();
}

class _LanguageDetailScreenState extends State<LanguageDetailScreen> {
  final List<String> pythonLessons = [
    'Lesson 1: Introduction to Python',
    'Lesson 2: Variables and Data Types',
    'Lesson 3: Conditional Statements',
    'Lesson 4: Loops in Python',
    'Lesson 5: Functions',
  ];

  Map<String, bool> _lessonCompletionStatus = {};

  @override
  void initState() {
    super.initState();
    _loadLessonCompletionStatus();
  }

  Future<void> _loadLessonCompletionStatus() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User is not authenticated.")),
        );
        return;
      }

      String currentUserName = currentUser.displayName ?? 'Unknown';

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('marks')
          .where('studentName', isEqualTo: currentUserName)
          .get();

      Map<String, bool> lessonCompletion = {};
      for (var lesson in pythonLessons) {
        lessonCompletion[lesson] = false;
      }

      for (var doc in snapshot.docs) {
        var data = doc.data();
        var subject = data['subject'] as String;
        if (lessonCompletion.containsKey(subject)) {
          lessonCompletion[subject] = true;
        }
      }

      setState(() {
        _lessonCompletionStatus = lessonCompletion;
      });
    } catch (e) {
      print("Error loading lesson completion status: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading lesson status.")),
      );
    }
  }

  Future<void> _checkCompletedStatus(BuildContext context) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User is not authenticated.")),
        );
        return;
      }

      String currentUserName = currentUser.displayName ?? 'Unknown';

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('marks')
          .where('studentName', isEqualTo: currentUserName)
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> completedLessons =
          snapshot.docs
              .where((doc) => pythonLessons.contains(doc.data()['subject']))
              .toList();

      if (completedLessons.length < pythonLessons.length) {
        _showIncompletePopup(context);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PredictionScreen()),
        );
      }
    } catch (e) {
      print("Error checking completed status: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error checking lesson status.")),
      );
    }
  }

  void _showIncompletePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lessons Incomplete"),
          content: const Text("You need to complete all lessons to proceed."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '${widget.language} Lessons',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: textColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: iconColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pythonLessons.length,
                itemBuilder: (context, index) {
                  String lesson = pythonLessons[index];
                  bool isCompleted = _lessonCompletionStatus[lesson] ?? false;

                  return Card(
                    elevation: 8,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: isCompleted
                        ? Colors.green.withOpacity(0.3)
                        : Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: primaryColor.withOpacity(0.8),
                        child: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        lesson,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Click to view details',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: primaryColor,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonScreen(
                              lessonTitle: lesson,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SquareButton(
                text: 'Completed Status',
                size: 50.0,
                onPressed: () {
                  _checkCompletedStatus(
                      context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
