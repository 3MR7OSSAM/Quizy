import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/components/Providers/QuizProvider.dart';
import '../../components/Methods/btm_alert.dart';
import '../../components/Widgets/customFormField.dart';
import '../splashView/splashView.dart';
import 'ForgetPasswordView.dart';
import 'TeacherSignUpView.dart';

class TeacherLoginView extends StatefulWidget {
  const TeacherLoginView({Key? key}) : super(key: key);

  @override
  State<TeacherLoginView> createState() => _TeacherLoginViewState();
}

late TextEditingController emailController;
late TextEditingController passwordController;
String email = '';
String password = '';
bool isNameEmpty = true;
bool obscureTextForm = true;
bool isLoading = false;
GlobalKey<FormState> formKey = GlobalKey();

class _TeacherLoginViewState extends State<TeacherLoginView> {
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.6,
        child: ModalProgressHUD(
          color: Colors.transparent,
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/login_Asset.png',
                  width: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Teacher Login ',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 50),
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
                        email = value;
                      });
                    },
                    hintText: 'Enter Your Email',
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                  child: CustomFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                    obscureText: obscureTextForm,
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                    hintText: 'Enter Your Password',
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordView(isProfile: false,)));
                  },
                    child: const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Forget Password ? ',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff713ABE).withOpacity(0.7),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TeacherSignUpView()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text('Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff713ABE).withOpacity(0.9),
                      ),
                      onPressed: () async{
                        final form = formKey.currentState;
                        if (form != null && form.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                            if(FirebaseAuth.instance.currentUser != null){
                              context.mounted ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SplashView())):null;
                            }
                          } on FirebaseException catch (e) {
                            context.mounted ? showBtmAlert(context, e.code.toUpperCase()) : null;
                          }finally{
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
