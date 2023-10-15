import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/Methods/btm_alert.dart';
import '../../components/Models/StudentModel.dart';
import '../../components/Providers/StudentProvider.dart';
import '../../components/Widgets/customFormField.dart';
import '../splashView/splashView.dart';

class StudentLoginView extends StatefulWidget {
  const StudentLoginView({Key? key}) : super(key: key);

  @override
  State<StudentLoginView> createState() => _StudentLoginViewState();
}

late TextEditingController controller;
String studentName = '';
bool isNameEmpty = true;

class _StudentLoginViewState extends State<StudentLoginView> {
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            'assets/images/student.png',
            width: 250,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Student Login ',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomFormField(
              obscureText: false,
              controller: controller,
              onChanged: (value) {
                setState(() {
                  studentName = value;
                  if (studentName != '') {
                    isNameEmpty = false;
                  } else {
                    isNameEmpty = true;
                  }
                });
              },
              hintText: 'Enter Your Name',
            ),
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff713ABE).withOpacity(0.9),
              ),
              onPressed: () {
                if (studentName == '') {
                  showBtmAlert(context, 'Please enter your name');
                } else {
                  studentProvider.studentLogin(StudentModel(name: studentName.trim(), isLoggedIn: true));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SplashView()));
                }
              },
              child: isNameEmpty
                  ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Continue'),
                  )
                  : Text('Continue as $studentName'))
        ],
      ),
    );
  }
}
