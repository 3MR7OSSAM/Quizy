class FinishedQuizModel {
  final String score;
  final String quizID;
  final String studentName;
  final DateTime date;
  final String? quizCreator;
  final String? subject;
  FinishedQuizModel({
    required this.score,
    required this.date,
     this.subject,
    required this.studentName,
     this.quizCreator,
    required this.quizID,
  });
}