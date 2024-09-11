import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_code_mentor/components/constants.dart';
import 'package:smart_code_mentor/components/squareButton.dart';
import 'package:smart_code_mentor/screens/language_detail_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class LessonScreen extends StatefulWidget {
  final String lessonTitle;

  LessonScreen({super.key, required this.lessonTitle});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final List<String> lessons = lessonDetails.keys.toList();
  GlobalKey _lessonKey = GlobalKey();
  GlobalKey _mcqKey = GlobalKey();
  GlobalKey _programmingKey = GlobalKey();
  GlobalKey _submitKey = GlobalKey();
  List<TargetFocus> targets = [];

  Map<int, String> programmingAnswers = {};
  Map<int, String> mcqAnswers = {};

  @override
  void initState() {
    super.initState();
    initTargets();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTutorial();
    });
  }

  void _submitAnswers() async {

    bool areMcqAnswersValid = validateMcqAnswers(5);


    bool areProgrammingAnswersValid = programmingAnswers.length == 5;

    if (!areMcqAnswersValid || !areProgrammingAnswersValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Validation Error',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          content: Text(
            'Please answer all MCQ questions and programming questions.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    int score = 0;

    final mcqs = lessonContent[widget.lessonTitle]?['mcqs'] ?? [];
    for (int i = 0; i < mcqs.length; i++) {
      final correctAnswer = mcqs[i]['answer'] as String;
      final selectedAnswer = mcqAnswers[i] ?? '';
      if (selectedAnswer == correctAnswer) {
        score += 1;
      }
    }

    final programmingQuestions =
        lessonContent[widget.lessonTitle]?['programming'] ?? [];
    for (int i = 0; i < programmingQuestions.length; i++) {
      final correctAnswer = programmingQuestions[i]['blanks']?.first ?? '';
      final userAnswer = programmingAnswers[i] ?? '';
      if (userAnswer == correctAnswer) {
        score += 1;
      }
    }

    String level;
    if (score >= 4) {
      level = 'Advanced';
    } else if (score >= 2) {
      level = 'Intermediate';
    } else {
      level = 'Beginner';
    }

    String getLevelMessage(String level) {
      switch (level) {
        case 'Advanced':
          return '''
Congratulations! You have achieved an Advanced level. Your performance indicates a high level of understanding and proficiency in the material. Keep up the great work and continue to explore more challenging concepts and applications in this field.
''';
        case 'Intermediate':
          return '''
Well done! You are at an Intermediate level. You have a solid understanding of the material and can apply your knowledge to various scenarios. To progress further, consider delving deeper into more complex topics and enhancing your skills through additional practice.
''';
        case 'Beginner':
          return '''
Great start! You are at a Beginner level. You have grasped the fundamental concepts and are on your way to building a strong foundation. Keep practicing and studying, and you will continue to grow and advance in your understanding of the material.
''';
        default:
          return 'Unable to determine your level.';
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Results',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Score: $score',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Current Status: $level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                getLevelMessage(level),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _navigateToHomePage(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName ?? 'Anonymous';
      final uid = user.uid;
      final subject = widget.lessonTitle;
      final lesson = lessonDetails[widget.lessonTitle] ?? '';

      await FirebaseFirestore.instance.collection('marks').add({
        'studentName': name,
        'subject': subject,
        'lesson': widget.lessonTitle,
        'marks': score,
        'status': level,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LanguageDetailScreen(
          language: 'Python',
        ),
      ),
    );
  }

  bool validateMcqAnswers(int totalQuestions) {
    for (int i = 0; i < totalQuestions; i++) {
      if (!mcqAnswers.containsKey(i) || mcqAnswers[i]!.isEmpty) {
        return false;
      }
    }
    return true;
  }

  String extractLessonNumber(String title) {
    final regex = RegExp(r'^Lesson \d+');
    final match = regex.firstMatch(title);
    return match != null ? match.group(0)! : 'Unknown Lesson';
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Lesson Content",
        keyTarget: _lessonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 40),
                Text(
                  "Read the Lesson",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Read the lesson carefully before attempting the questions.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "MCQ Section",
        keyTarget: _mcqKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Answer the MCQs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Make sure to answer all the MCQs based on the lesson content.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Programming Section",
        keyTarget: _programmingKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Fill in the Programming Questions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Answer the programming questions by filling in the blanks.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Submit Button",
        keyTarget: _submitKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Submit Your Answers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Click here to submit your answers after completing the questions.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lessonDetail =
        lessonDetails[widget.lessonTitle] ?? 'Lesson content not available';
    final lessonContentData = lessonContent[widget.lessonTitle] ?? {};

    final mcqs = lessonContentData['mcqs'] ?? [];
    final programmingQuestions = lessonContentData['programming'] ?? [];

    final lessonNumber = extractLessonNumber(widget.lessonTitle);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          lessonNumber,
          key: _lessonKey,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: iconColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.lessonTitle,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                lessonDetail,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),


              Text(
                'Multiple Choice Questions (MCQs)',
                key: _mcqKey,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              ...mcqs.map((mcq) {
                final index = mcqs.indexOf(mcq);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mcq['question'] ?? ''),
                    ...((mcq['options'] as List<String>).map((option) {
                      return ListTile(
                        title: Text(option),
                        leading: Radio<String>(
                          value: option,
                          groupValue: mcqAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              mcqAnswers[index] = value ?? '';
                            });
                          },
                        ),
                      );
                    }).toList()),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),

              const SizedBox(height: 30),


              Text(
                'Programming Questions',
                key: _programmingKey,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < programmingQuestions.length; i++) ...[
                Text(programmingQuestions[i]['question'] ?? ''),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: programmingQuestions[i]['code']?.replaceAll(
                              '___',
                              '____',
                            ) ??
                            '',
                      ),
                    ],
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      programmingAnswers[i] = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Fill in the blank',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
              ],


              Center(
                child: SquareButton(
                  key: _submitKey,
                  text: 'Submit',
                  size: 50.0,
                  onPressed: () {
                    _submitAnswers();
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

void showTutorial() {
    TutorialCoachMark(
      targets: targets, // Pass the list of target focus
      colorShadow: Colors.black87,
      textSkip: "SKIP",
      paddingFocus: 10,
      onFinish: () {
        print("Tutorial finished");
      },
    )..show(context: context); // Correctly pass the context here
  }

}
