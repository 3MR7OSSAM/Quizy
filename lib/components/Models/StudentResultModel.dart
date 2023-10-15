class StudentResultModel {
  final String studentName;
  final double score;
  final DateTime date;

  StudentResultModel({
    required this.studentName,
    required this.score,
    required this.date,
  });
}
class QuizModel {
  final String quizCode;
  final List<StudentResultModel> students;

  QuizModel({
    required this.quizCode,
    required this.students,
  });
}