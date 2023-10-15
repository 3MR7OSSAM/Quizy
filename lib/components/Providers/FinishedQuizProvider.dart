import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import '../Methods/btm_alert.dart';
import '../Models/FinishedQuizModel.dart';
import '../Models/StudentResultModel.dart';
class FinishedQuizProvider extends ChangeNotifier {
  static final List<FinishedQuizModel> _finishedList = [];
  static final List<QuizModel> _quizzesList = [];
  static final List<int> quizCodeList = [];

  List<int> get getQuizCodes {
    return quizCodeList;
  }

  List<FinishedQuizModel> get getFinishedQuizzes {
    return _finishedList;
  }
  List<QuizModel> get getTeacherQuizzes {
    return _quizzesList;
  }


  Future<void> addFinishedQuizzes({required FinishedQuizModel finishedQuizModel , required context}) async {
    try {
      Random random = Random();
      int student = random.nextInt(900000) + 10000;
      // Create a map of questions data
      _finishedList.add(finishedQuizModel);
      Map<String, dynamic> quizData = {
        'QuizId': finishedQuizModel.quizID,
        //'teacherID':FirebaseAuth.instance.currentUser!.uid,
        'subject':finishedQuizModel.quizID,
      };
        Map<String, dynamic> finishedQuizData = {
          'studentName':finishedQuizModel.studentName,
          'score':finishedQuizModel.score,
          'date':finishedQuizModel.date,
        };

        // Add the question to the quiz data
        quizData['S${student.toString()}'] = finishedQuizData;

      // Add the quiz data to Firestore
      await FirebaseFirestore.instance.collection('FinishedQuizzes').doc(finishedQuizModel.quizID).update(quizData);

    } catch (e) {
      showBtmAlert(context, '$e');
    }
  }




  Future<List<String>> getQuizIdsByTeacherId(String teacherId) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('FinishedQuizzes') // Replace 'Quiz' with your collection name
          .where('teacherID', isEqualTo: teacherId)
          .get();

      List<String> quizIds = querySnapshot.docs.map((doc) => doc.id).toList();
      return quizIds;
    } catch (e) {
      print("Error getting quiz IDs by teacher ID: $e");
      return [];
    }
  }




  Future<void> fetchFinishedQuizzes({required String teacherID,}) async {
    try {
      _quizzesList.clear(); // Clear the existing data

      List<String> quizIds = await getQuizIdsByTeacherId(teacherID);

      for (String quizId in quizIds) {
        // Fetch the quiz data for each quiz ID
        DocumentSnapshot quizSnapshot =
        await FirebaseFirestore.instance.collection('FinishedQuizzes').doc(quizId).get();
        if (quizSnapshot.exists) {
          Map<String, dynamic>? quizData = quizSnapshot.data() as Map<String, dynamic>?;

          if (quizData != null) {
            // Extract quiz code
            String quizCode = quizData['QuizId'] ?? '';
            List<StudentResultModel> students = [];

            // Check if the quiz data has maps of students (S286344, S268326, etc.)
            for (String studentKey in quizData.keys) {
              if (quizData[studentKey] is Map<String, dynamic>) {
                Map<String, dynamic> studentData = quizData[studentKey] as Map<String, dynamic>;

                // Extract student data
                String studentName = studentData['studentName'] ?? '';
                double score = double.parse(studentData['score'] ?? '0');
                DateTime date = studentData['date'] is Timestamp
                    ? (studentData['date'] as Timestamp).toDate()
                    : DateTime.now();

                // Create a StudentModel instance and add it to the students list
                StudentResultModel student = StudentResultModel(
                  studentName: studentName,
                  score: score,
                  date: date,
                );

                students.add(student);
              }
            }

            // Create a QuizModel instance for this quiz and add it to the quizzes list
            QuizModel quiz = QuizModel(
              quizCode: quizCode,
              students: students,
            );

            _quizzesList.add(quiz);
          }
        }
      }
    } catch (e) {
      //showBtmAlert(context, '$e');
    }
    notifyListeners(); // Moved outside the try-catch block
  }
  void quizzesListClear() {
    _finishedList.clear();
  }
}
