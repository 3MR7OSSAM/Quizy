import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/QuizModel.dart';


class AddQuizProvider extends ChangeNotifier{
  Future<void> addQuiz(String quizId, List<QuestionsModel> questions,String subject) async {
    try {
      // Create a map of questions data
      Map<String, dynamic> quizData = {
        'QuizId': quizId,
        'teacherID':FirebaseAuth.instance.currentUser!.uid,
        'subject':subject,
        'questions': {},
      };

      for (int i = 0; i < questions.length; i++) {
        QuestionsModel question = questions[i];

        // Generate a unique question ID (e.g., Q1, Q2, Q3, ...)
        String questionId = 'Q${i + 1}';

        // Create a map for each question
        Map<String, dynamic> questionData = {
          'question': question.question,
          'correctAnswer': question.correctAnswer,
          'answers': question.answers,
        };

        // Add the question to the quiz data
        quizData['questions'][questionId] = questionData;
      }

      // Add the quiz data to Firestore
      await FirebaseFirestore.instance.collection('Quiz').doc(quizId).set(quizData);
      await FirebaseFirestore.instance.collection('FinishedQuizzes').doc(quizId).set({
        'QuizId' : quizId,
        'teacherID' : FirebaseAuth.instance.currentUser!.uid,
      });
      print('Quiz added successfully');
    } catch (e) {
      print("Error adding quiz: $e");
    }
  }
}