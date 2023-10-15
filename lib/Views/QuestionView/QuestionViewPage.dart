import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/Models/FinishedQuizModel.dart';
import '../../components/Models/QuizModel.dart';
import '../../components/Providers/FinishedQuizProvider.dart';
import '../../components/Providers/StudentProvider.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../ScoreView/ScoreViewPage.dart';


class QuestionViewPage extends StatefulWidget {
  QuestionViewPage({Key? key, required this.questions, required this.quizCode}) : super(key: key);
  List <QuestionsModel> questions ;
  final String quizCode;
  @override
  State<QuestionViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<QuestionViewPage> {

  int currentIndex = 0;
  String selectedAnswer =''; // Track the selected answer index
  int selectedAnswerIndex =-1; // Track the selected answer index
  Color rightColor = Colors.green;
  Color wrongColor = Colors.red;
  int score = 0;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final finishedQuizProvider = Provider.of<FinishedQuizProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);
    final String studentName = studentProvider.getStudentData.name;
    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: LinearProgressIndicator(
                        value: currentIndex / widget.questions.length,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Q${currentIndex + 1})  ${ widget.questions[currentIndex].question}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 25),
                      itemCount:  widget.questions[currentIndex].answers.length,
                      itemBuilder: (context, index) {
                        final correctAnswer =  widget.questions[currentIndex].correctAnswer;
                        final correctAnswerIndex =widget.questions[currentIndex].answers.indexOf(correctAnswer);
                        return InkWell(

                          onTap: isSelected ? null :() {
                            selectedAnswer = widget.questions[currentIndex].answers[index];
                            setState(() {
                              isSelected = true;
                              selectedAnswerIndex = widget.questions[currentIndex].answers.indexOf(selectedAnswer);
                            });
                            if(selectedAnswerIndex == correctAnswerIndex ){
                              score++;
                            }
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                isSelected = false;
                                if (currentIndex + 1 < widget.questions.length) {
                                  currentIndex += 1;
                                  selectedAnswerIndex = -1;
                                }
                                else if(currentIndex +1 == widget.questions.length) {
                                  finishedQuizProvider.addFinishedQuizzes(
                                      finishedQuizModel: FinishedQuizModel(
                                          score: '${score/widget.questions.length*100}',
                                          date: DateTime.now(),
                                          //subject: 'Math',
                                          studentName: studentName,
                                          //quizCreator: 'Admin',
                                          quizID: widget.quizCode,
                                      ),
                                      context: context
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  ScoreViewPage(
                                            score: score,
                                            totalQuestions: widget.questions.length,
                                          )));
                                }
                              });
                            });
                          },
                          child: Card(
                            color: selectedAnswerIndex == index
                                ? (index == correctAnswerIndex
                                ? rightColor
                                : wrongColor)
                                : null,
                            child: ListTile(
                              title: Text(
                                  widget.questions[currentIndex].answers[index]),
                            ),
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: ()  {
                        setState(() {
                          if (currentIndex + 1 <widget.questions.length) {
                            currentIndex += 1;
                            selectedAnswerIndex = -1; // Reset selected answer
                          }else{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ScoreViewPage(
                                      score: score,
                                      totalQuestions: widget.questions.length,
                                    )));
                          }
                        });

                      },
                      child: Text(selectedAnswerIndex == -1 ? 'Skip' : 'Next'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}