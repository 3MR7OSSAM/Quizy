import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/Methods/btm_alert.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import '../../components/Widgets/customFormField.dart';

class TeacherSignUpView extends StatefulWidget {
  const TeacherSignUpView({Key? key}) : super(key: key);

  @override
  State<TeacherSignUpView> createState() => _TeacherLoginViewState();
}

late TextEditingController emailController;
late TextEditingController nameController;
late TextEditingController passwordController;
String email = '';
String name = '';
String password = '';
bool isNameEmpty = true;
bool obscureTextForm = true;
bool isLoading = false;
GlobalKey<FormState> formKey = GlobalKey();

class _TeacherLoginViewState extends State<TeacherSignUpView> {
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: GradientBoxWidget(
              child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      'assets/images/signup_asset.png',
                      width: 300,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Teacher SignUp ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 50),
                      child: CustomFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            name = value.trim();
                          });
                        },
                        hintText: 'Full Name',
                        obscureText: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 50),
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
                        hintText: 'Email',
                        obscureText: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 50),
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
                        hintText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff713ABE).withOpacity(0.9),
                      ),
                      onPressed: () async {
                        final form = formKey.currentState;
                        if (form != null && form.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email.trim(), password: password);
                            final User? user =
                                FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance
                                .collection('Teachers')
                                .doc(user!.uid)
                                .set({
                              'id': user.uid,
                              'name': name,
                              'email': email,
                              'teacherQuiz': [],
                              'AccountCreationDate': Timestamp.now(),
                            });
                            context.mounted
                                ? showBtmAlert(context,
                                    'Account Successfully Created Please Log In')
                                : null;
                          } on FirebaseException catch (e) {
                            context.mounted
                                ? showBtmAlert(context, e.message.toString())
                                : null;
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text('Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
