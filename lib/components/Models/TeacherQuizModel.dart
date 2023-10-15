class TeacherQuizModel {
  final String quizID;
  final int numberOfStudents;
  final DateTime date;
  final String subject;
  TeacherQuizModel({
    required this.date,
    required this.subject,
    required this.numberOfStudents,
    required this.quizID,
  });
}