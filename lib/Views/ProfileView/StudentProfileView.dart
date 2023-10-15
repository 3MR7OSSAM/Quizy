import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/Methods/AlertDialog.dart';
import '../../components/Models/StudentModel.dart';
import '../../components/Providers/StudentProvider.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/SettingsWidget.dart';
import '../splashView/splashView.dart';
class StudentProfileView extends StatefulWidget {
   const StudentProfileView({Key? key}) : super(key: key);

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  TextEditingController nameController = TextEditingController();
   String newName = '';
  @override
  Widget build(BuildContext context) {
      final studentProvider = Provider.of<StudentProvider>(context);
      final studentData = studentProvider.getStudentData;
      List<String> nameParts = studentData.name.split(' ');
      String firstName = nameParts[0];

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
                  'Hi, ${firstName.toUpperCase()} 👋',
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
              SettingsWidget(title: 'Change Name', icon: Icons.account_circle,onTap: (){
                showAlertDialog(context: context, subjectController: nameController, onChanged: (value) {
                  newName = value;
                }, onContinue: (){
                  if(newName != ''){
                    studentProvider.studentLogin(StudentModel(name:  newName, isLoggedIn: true,));
                    setState(() {
                      studentProvider.getStudentData;
                    });
                  }else{
                    Navigator.pop(context);
                  }
                }, title: 'Edit your name', subTitle: 'Enter the new name');
              },),
              SettingsWidget(title: 'Log Out', icon: Icons.logout,onTap: (){
                studentProvider.studentLogOut(context: context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SplashView()));
              },),
            ],
          ),

        ),
      ),
    );
  }
}
