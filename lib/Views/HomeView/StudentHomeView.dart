import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/Models/FinishedQuizModel.dart';
import '../../components/Providers/FinishedQuizProvider.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/EmptyView.dart';
import '../../components/Widgets/FininshedQuzeWidget.dart';
import '../../components/Widgets/GlassNavBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../ProfileView/StudentProfileView.dart';
import '../QuizCodeView/QuizCodeView.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({Key? key}) : super(key: key);

  String dateFormat({required DateTime date}) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - hh:mm a');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final finishedQuizProvider = Provider.of<FinishedQuizProvider>(context);
    List<FinishedQuizModel> finishedQuizList =
        finishedQuizProvider.getFinishedQuizzes;

    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenHeight = mediaQueryData.size.height;

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (builder, constraints) {
            return GradientBoxWidget(
              child: SizedBox(
                width: double.infinity,
                child: finishedQuizList.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      ShowIcons: true,
                      isBigLogo: false,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Finished Quizzes :',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.7,
                      child: ListView.builder(
                        itemCount: finishedQuizList.length,
                        itemBuilder: (context, index) {
                          String formattedDate =
                          dateFormat(date: finishedQuizList[index].date);
                          return FinishedQuizWidget(
                            percentage: double.parse(finishedQuizList[index].score) / 100,
                            date: formattedDate,
                            subject: 'Quiz : ${finishedQuizList[index].quizID}',
                          );
                        },
                      ),
                    ),
                    Center(
                      child: GlassNavBar(
                        title: 'Your Quizzes',
                        profilePage: StudentProfileView(),
                        quizPage: QuizCodeView(),
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    EmptyView(title: 'You haven\'t finished any quizzes yet!'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5D12D2),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizCodeView()));
                      },
                      child: Text('Start Now', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: screenHeight * 0.2),
                    Center(
                      child: GlassNavBar(
                        title: 'Your Quizzes',
                        profilePage: StudentProfileView(),
                        quizPage: QuizCodeView(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
