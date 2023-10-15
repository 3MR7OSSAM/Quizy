import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/components/Widgets/CustomAppBar.dart';
import '../../components/Methods/btm_alert.dart';
import '../../components/Providers/QuizProvider.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/customFormField.dart';
import '../QuestionView/QuestionViewPage.dart';


class QuizCodeView extends StatefulWidget {
  const QuizCodeView({Key? key}) : super(key: key);

  @override
  _QuizCodeViewState createState() => _QuizCodeViewState();
}

class _QuizCodeViewState extends State<QuizCodeView> {
  late TextEditingController controller;
  String enteredCode = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenWidth = mediaQueryData.size.width;
    final logoWidth = screenWidth * 0.4;
    final textFieldWidth = screenWidth * 0.75;
    final buttonWidth = screenWidth * 0.3;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox.expand(
            child: GradientBoxWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: 'Start Your Quiz',
                      endIconOnTap: (){
                        //logic should be here
                      },
                      startIconOnTap: (){
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
                    SizedBox(height: MediaQuery.sizeOf(context).height *0.2,),
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: logoWidth,
                    ),
                    const Text(
                      'Release your knowledge',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenWidth * 0.2,
                        bottom: screenWidth * 0.11,
                      ),
                      child: SizedBox(
                        width: textFieldWidth,
                        child: CustomFormField(
                          obscureText: false,
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              enteredCode = value;
                            });
                          }, hintText: 'Enter quiz code',
                          isCenterHint: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5D12D2)
                        ),
                        onPressed: () async {
                          if (enteredCode.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              final questions = await quizProvider.fetchQuestionsForQuiz(enteredCode);
                              if (questions.isNotEmpty && context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  QuestionViewPage(questions: questions, quizCode:enteredCode,),
                                  ),
                                );
                              } else {
                                if (context.mounted) {
                                  showBtmAlert(
                                      context, 'Check the code and Ftry again');
                                }
                              }
                            } catch (e) {
                              // Handle error
                            } finally {
                              await Future.delayed(Duration
                                  .zero); // Await a zero-delay Future to allow setState to complete
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            showBtmAlert(context, 'Please enter a code');
                          }
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
