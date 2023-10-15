import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/QuizModel.dart';


class QuizProvider extends ChangeNotifier{
  final List<QuestionsModel> _questionsList = [];
  final String _subject ='';
   bool? permissions ;

  String get getSubject {
    return _subject;
  }
  List<QuestionsModel> get getQuestions {
    return _questionsList;
  }

  Future<List<QuestionsModel>> fetchQuestionsForQuiz(String quizId) async {
    List<QuestionsModel> questions = [];

    try {
      QuerySnapshot quizSnapshot = await FirebaseFirestore.instance.collection('Quiz').where('QuizId', isEqualTo: quizId).get();

      if (quizSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> questionData = quizSnapshot.docs[0]['questions'];

        questionData.forEach((key, value) {
          Map<String, dynamic> questionMap = value as Map<String, dynamic>;
          String questionText = questionMap['question'] ?? '';
          String correctAnswer = questionMap['correctAnswer'] ?? '';
          List<String> answerChoices = List<String>.from(questionMap['answers']) ;

          QuestionsModel question = QuestionsModel(
            question: questionText,
            correctAnswer: correctAnswer,
            answers: answerChoices,
          );

          questions.add(question);
          questions.forEach((element) {
            print(element.question);
          });
        });
      }
    } catch (e) {
      print("Error fetching questions: $e");
    }

    return questions;
  }
}