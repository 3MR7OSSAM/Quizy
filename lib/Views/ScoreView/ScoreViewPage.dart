import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../HomeView/StudentHomeView.dart';
import '../QuizCodeView/QuizCodeView.dart';


class ScoreViewPage extends StatelessWidget {

  const ScoreViewPage({Key? key, required this.score, required this.totalQuestions}) : super(key: key);
  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
   double scorePresent = (score/totalQuestions )*100;
   String stringScore = scorePresent.toStringAsFixed(2);
  scorePresent = double.parse(stringScore);
    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                endIconOnTap: (){
                  //logic should be here
                },
                startIconOnTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  const StudentHomeView()));
                },
                ShowIcons: false,
                isBigLogo: false,
                startIcon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 120,),
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 15.0,
                animation: true,
                percent: scorePresent/100,
                center: Text(
                  "$scorePresent%",
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0,color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                progressColor: scorePresent<50 ? Colors.red:Colors.green,
              ),
              const SizedBox(height: 25,),
              Text('You Have Got $score Out Of $totalQuestions',style: const TextStyle(fontSize: 15.0,color: Colors.white,decoration: TextDecoration.underline)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400
                        ),
                        onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const QuizCodeView()));
                    }, child: const Text('Try Again')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600
                      ),
                      onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  const StudentHomeView()));
                    }, child: const Text('Continue', style: TextStyle(fontSize: 15.0,color: Colors.white,),),),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
