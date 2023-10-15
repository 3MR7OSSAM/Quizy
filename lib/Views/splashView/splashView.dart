import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import '../../components/Providers/FinishedQuizProvider.dart';
import '../../components/Providers/StudentProvider.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../HomeView/StudentHomeView.dart';
import '../HomeView/TeacherHomeView.dart';
import '../LoginView/LoginOptions.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4000), () async {
      final studentProvider =
          Provider.of<StudentProvider>(context, listen: false);
      final studentData = studentProvider.getStudentData;
        if (studentData.isLoggedIn) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StudentHomeView()));
        } else if (FirebaseAuth.instance.currentUser != null) {
          final finishedQuizProvider =
              Provider.of<FinishedQuizProvider>(context, listen: false);
          await finishedQuizProvider.fetchFinishedQuizzes(
            teacherID: FirebaseAuth.instance.currentUser!.uid,
          );
          context.mounted
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TeacherHomeView()))
              : null;
        } else {
          context.mounted
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TabBarDemo()))
              : null;
        }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData =
        MediaQuery.of(context); // Only get MediaQueryData once.
    double screenWidth = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.6,
                child: const ImageFade(
                  image: AssetImage('assets/images/app_logo.png'),
                  duration: Duration(milliseconds: 1000),
                  syncDuration: Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
