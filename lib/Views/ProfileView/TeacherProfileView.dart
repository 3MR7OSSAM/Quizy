import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/SettingsWidget.dart';
import '../LoginView/ForgetPasswordView.dart';
import '../splashView/splashView.dart';

class TeacherProfileView extends StatelessWidget {
  const TeacherProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String teacherName = FirebaseAuth.instance.currentUser!.email.toString();
    List<String> parts = teacherName.split('@');
    teacherName = parts[0].toString();
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hi, ${teacherName.toUpperCase()} 👋',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 10),
              child: Text(
                'What do you wish to do ?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ),
            SettingsWidget(title: 'Change Password', icon: Icons.key,onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgetPasswordView(isProfile: true,)));
            }),
            SettingsWidget(title: 'Log Out', icon: Icons.logout,onTap: () async{
              await FirebaseAuth.instance.signOut();
              context.mounted ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashView())): null;
            }),
            SettingsWidget(title: 'About Quizy', icon: Icons.question_answer,onTap: (){}),
          ],
        ),
      ),
    ));
  }
}
