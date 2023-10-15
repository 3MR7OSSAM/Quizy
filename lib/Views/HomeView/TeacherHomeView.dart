import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/Methods/btm_alert.dart';
import '../../components/Providers/FinishedQuizProvider.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/EmptyView.dart';
import '../../components/Widgets/GlassNavBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/TeacherQuizzesWidget.dart';
import '../AddQuizView/AddQuizView.dart';
import '../ProfileView/TeacherProfileView.dart';
import '../StudentsScoreView/QuizScoreView.dart';

class TeacherHomeView extends StatelessWidget {
  TeacherHomeView({Key? key}) : super(key: key);

  String dateFormat({required DateTime date}) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - hh:mm a');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData =
        MediaQuery.of(context); // Only get MediaQueryData once.
    double screenHeight = mediaQueryData.size.height;
    return Consumer<FinishedQuizProvider>(
        builder: (context, finishedQuizProvider, child) {
      final finishedQuizProvider = Provider.of<FinishedQuizProvider>(context);
      final finishedQuizList = finishedQuizProvider.getTeacherQuizzes;
      return SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await finishedQuizProvider.fetchFinishedQuizzes(
                teacherID: FirebaseAuth.instance.currentUser!.uid);
            //return Text('data');
          },
          child: Scaffold(
            body: LayoutBuilder(
              builder: (builder, constrains) {
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
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  'Your Quizzes :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: constrains.maxHeight * 0.7,
                                child: ListView.builder(
                                    itemCount: finishedQuizList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            if (finishedQuizList[index]
                                                .students
                                                .isEmpty) {
                                              showBtmAlert(context,
                                                  'No Students finished this quiz yet !');
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizScoreView(
                                                            quizID:
                                                                finishedQuizList[
                                                                        index]
                                                                    .quizCode,
                                                          )));
                                            }
                                          },
                                          child: TeacherQuizzesWidget(
                                            quizCode:
                                                'Quiz : ${finishedQuizList[index].quizCode}',
                                            studentsNum: finishedQuizList[index]
                                                .students
                                                .length
                                                .toString(),
                                          ));
                                    }),
                              ),
                              const Center(
                                  child: GlassNavBar(
                                title: 'Your Quizzes',
                                profilePage: TeacherProfileView(),
                                quizPage: AddQuizView(),
                              ))
                            ],
                          )
                        : Column(
                            children: [
                              const EmptyView(
                                isTeacher: true,
                                title: 'You have\'t created any quizzes yet!',
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff5D12D2)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddQuizView()));
                                  },
                                  child: const Text(
                                    'Create Now',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(
                                height: screenHeight * .2,
                              ),
                              const Center(
                                  child: GlassNavBar(
                                title: 'Your Quizzes',
                                profilePage: TeacherProfileView(),
                                quizPage: AddQuizView(),
                              ))
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
