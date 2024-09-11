import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_code_mentor/components/constants.dart'; // Progress bar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  List<Map<String, dynamic>> completedLessons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
    if (user != null) {
      _fetchStudentProgress(user.displayName!);
    }
  }

  void _fetchStudentProgress(String studentName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('marks')
        .where('studentName', isEqualTo: studentName)
        .get();

    final List<Map<String, dynamic>> lessons =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    lessons.sort((a, b) {
      final lessonNumberA = _extractLessonNumber(a['subject']);
      final lessonNumberB = _extractLessonNumber(b['subject']);
      return lessonNumberA.compareTo(lessonNumberB);
    });

    setState(() {
      completedLessons = lessons;
      _isLoading = false;
    });
  }

  int _extractLessonNumber(String? subject) {
    if (subject == null) return 0;
    final regex = RegExp(r'Lesson (\d+)');
    final match = regex.firstMatch(subject);
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage = completedLessons.length / 5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 4,
        title: const Center(
          child: Text(
            'Home Screen',
            style: TextStyle(
              fontSize: 28.0,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _user != null
                        ? Text(
                            'Hi, ${_user!.displayName ?? 'Student'}!',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )
                        : const Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const SizedBox(height: 20),
                    // Progress Bar
                    Center(
                      child: Text(
                        'Your Course Progress',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${completedLessons.length}/5 Lessons Completed',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearPercentIndicator(
                      lineHeight: 12.0,
                      percent: progressPercentage,
                      backgroundColor: Colors.grey[300],
                      progressColor: Colors.blue,
                      barRadius: const Radius.circular(16),
                      trailing: Text('${(progressPercentage * 100).toInt()}%'),
                    ),
                    const SizedBox(height: 20),
                    // Check if there are any completed lessons
                    completedLessons.isEmpty
                        ? _buildNoLessonsMessage()
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemCount: completedLessons.length,
                            itemBuilder: (context, index) {
                              final lesson = completedLessons[index];
                              return _buildLessonCard(lesson);
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildNoLessonsMessage() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.sentiment_satisfied_alt,
            size: 80,
            color: Colors.blueGrey[300],
          ),
          const SizedBox(height: 20),
          const Text(
            "No lessons completed yet!",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Start your first lesson and track your progress here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.school,
              color: Colors.blue,
              size: 40,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson['subject'] ?? 'No Subject',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Marks: ${lesson['marks'] != null ? lesson['marks'].toString() + '/10' : 'N/A'}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Status: ${lesson['status'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(Icons.book_outlined,
                          color: Colors.blueGrey, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Subject: ${'Python'}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
