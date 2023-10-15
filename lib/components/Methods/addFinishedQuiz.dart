import 'package:provider/provider.dart';
import '../Providers/FinishedQuizProvider.dart';
import '../Models/FinishedQuizModel.dart';
void addFinishedQuiz({
  required int score,
  required String subject,
  required String studentName,
  required String quizCreator,
  required int questionsNumber,
  required String quizId,
  context,
}) {
  final finishedQuizProviderProvider =
      Provider.of<FinishedQuizProvider>(context, listen: false);
  finishedQuizProviderProvider.addFinishedQuizzes(
    finishedQuizModel: FinishedQuizModel(
      score: '${score / questionsNumber * 100}',
      date: DateTime.now(),
      subject: subject,
      studentName: studentName,
      quizCreator: quizCreator,
      quizID: quizId,
    ),
    context: context,
  );
}
