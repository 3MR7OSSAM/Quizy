import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/Models/StudentResultModel.dart';
import '../../components/Providers/FinishedQuizProvider.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/FininshedQuzeWidget.dart';
import '../../components/Widgets/GlassNavBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../AddQuizView/AddQuizView.dart';
import '../ProfileView/TeacherProfileView.dart';

class QuizScoreView extends StatelessWidget {
  const QuizScoreView({Key? key, required this.quizID}) : super(key: key);
  final String quizID;
  @override
  Widget build(BuildContext context) {
  final finishedQuizProvider = Provider.of<FinishedQuizProvider>(context);
  final quizData = finishedQuizProvider.getTeacherQuizzes.firstWhere((element) => element.quizCode == quizID);
  final List <StudentResultModel> students = quizData.students;
  final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
  double screenHeight = mediaQueryData.size.height;

    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                startIconOnTap: () {
                  Navigator.pop(context);
                },
                ShowIcons: false,
                isBigLogo: false,
                startIcon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text('Quiz Number $quizID :',style: const TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18),),
              ),
              SizedBox(
                height: screenHeight*0.7,
                child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context,index){
                      final double score = double.parse((students[index].score/100).toStringAsFixed(2));
                      String formattedDate = dateFormat(date: students[index].date);
                      return FinishedQuizWidget(percentage: score, date: formattedDate, subject: 'Student : ${students[index].studentName}',);
                    }),
              ),
               const Center(child: GlassNavBar(title: 'Quizzes', profilePage: TeacherProfileView(), quizPage: AddQuizView(),))
            ],
          ),
        ),
      ),
    );
  }
  String dateFormat({required DateTime date}) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - hh:mm a');
    return formatter.format(date);
  }
}
