import 'package:flutter/material.dart';
import 'package:smart_code_mentor/screens/language_detail_screen.dart';
import 'package:smart_code_mentor/components/constants.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  final List<Map<String, dynamic>> languages = [
    {'name': 'Python', 'icon': Icons.code},
    {'name': 'Java', 'icon': Icons.computer},
    {'name': 'C++', 'icon': Icons.memory},
    {'name': 'JavaScript', 'icon': Icons.javascript},
    {'name': 'C#', 'icon': Icons.developer_mode},
  ];

  void _onCardTap(String language) {
    if (language == 'Python') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LanguageDetailScreen(language: language),
        ),
      );
    } else {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Course Content Pending'),
            content: Text('The course content for $language is coming soon.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 4,
        title: const Center(
          child: Text(
            'Courses',
            style: TextStyle(
              fontSize: 28.0,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 3 / 2, 
          ),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index]['name'];
            final icon = languages[index]['icon'];
            return GestureDetector(
              onTap: () => _onCardTap(language),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 40.0,
                        color:
                            primaryColor,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        language,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
