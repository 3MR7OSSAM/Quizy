import 'package:flutter/material.dart';

class TeacherQuizzesWidget extends StatelessWidget {
  const TeacherQuizzesWidget({Key? key, required this.quizCode, required this.studentsNum}) : super(key: key);
  final String quizCode;
  final String studentsNum;
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenHeight = mediaQueryData.size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Container(
        height: screenHeight*0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white
        ),
        child: ListTile(
          title: Text(quizCode),
          subtitle: Text('Number Of Students :$studentsNum'),
        ),
      ),
    );
  }
}
