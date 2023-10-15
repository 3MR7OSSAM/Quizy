import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quiz_app/Views/LoginView/TeacherLogin.dart';

import '../../components/Methods/btm_alert.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/customFormField.dart';
import 'LoginOptions.dart';


class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key, required this.isProfile}) : super(key: key);
  final bool isProfile;
  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late TextEditingController emailController;
  bool isLoading= false;
  String email = '';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        decoration: TextDecoration.underline);

    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: GradientBoxWidget(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                CustomAppBar(
                  startIconOnTap: () {
                    widget.isProfile ? Navigator.pop(context) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TabBarDemo()));
                  },
                  ShowIcons: false,
                  isBigLogo: false,
                  startIcon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Reset Your Password',
                  style: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 13),
                  child: CustomFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    hintText: 'Enter Your Email',
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "After You Click Send , Reset Password Link Will Be Sent To Your Email",
                    style: textStyle.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign
                        .center, // Center align the text within the Text widget
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5D12D2)),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final form = formKey.currentState;
                     if(form != null && form.validate()){
                       form.save();
                      sendEmail(email.toString(),context);

                     }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Text('Send'),
                    ))
              ],
          ),
            ),
      ),
        ),
    ));
  }
  void sendEmail(String email, context)async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.toString().trim());
      setState(() {
        isLoading = false;
      });
      showBtmAlert(context , 'An Email With password reset Link has been sent to your e-mail');
    }on FirebaseException catch  (e) {
      showBtmAlert(context , e.message.toString());
    }
    catch(e){
      showBtmAlert(context , e.toString());
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

}
