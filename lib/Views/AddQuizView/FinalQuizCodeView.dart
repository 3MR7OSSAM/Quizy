import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../components/Methods/btm_alert.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../HomeView/TeacherHomeView.dart';


class FinalQuizCodeView extends StatelessWidget {
  const FinalQuizCodeView({Key? key, required this.quizCode}) : super(key: key);
  final String quizCode;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
        color: Color(0xffFF6AC2),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        decoration: TextDecoration.underline);
    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppBar(
                    endIconOnTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherHomeView()));
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
                    endIcon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.2),
                    child: const Text(
                      "Your Quiz Was Created Successfully",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //  const SizedBox(height: 35,),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                    child: Text(
                      'Quiz Code :',
                      style: textStyle.copyWith(
                          color: Colors.white, decoration: TextDecoration.none),
                    ),
                  ),

                  Container(
                    width: 150,
                    height: 53,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      quizCode,
                      style: textStyle,
                    )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      "Share the code with your students\nso they could start the quiz",
                      style: textStyle.copyWith(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign
                          .center, // Center align the text within the Text widget
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF6AC2).withOpacity(0.7),
                      ),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: quizCode));
                        context.mounted ? showBtmAlert(context, 'Code Copied Successfully'):null;
                      },
                      child: Text(
                        'Copy Code',
                        style: textStyle.copyWith(
                            color: Colors.white, decoration: TextDecoration.none),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
