import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/QuizModel.dart';
 final List<QuestionsModel> _questionsList = [];

List<QuestionsModel> get getOrders {
  return _questionsList;
}
Future<void> fetchOrders(context, String quizID) async {
  try {

    QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
        .collection('Quiz')
        .where('QuizId', isEqualTo: quizID)
        .get();
    QuestionsModel createQuestionModel(QueryDocumentSnapshot doc) {
      return QuestionsModel(
        question: doc.get('question'),
        answers: doc.get('answers'),
        correctAnswer: doc.get('correctAnswer'),
      );
    }

    for (var doc in orderSnapshot.docs) {
      _questionsList.insert(0, createQuestionModel(doc));
    }

  } on FirebaseException catch (e) {
    print(e);
    // showBtmAlert(context, 'Error fetching orders: $e');
  }
}
