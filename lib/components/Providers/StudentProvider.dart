import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/components/Providers/FinishedQuizProvider.dart';

import '../Models/StudentModel.dart';
class StudentProvider extends ChangeNotifier{
   StudentModel _studentData = StudentModel(name: '', isLoggedIn: false);
   StudentModel get getStudentData {
     return _studentData;
   }
  void studentLogin(StudentModel student){
    _studentData.name = student.name;
    _studentData.isLoggedIn = student.isLoggedIn;
    ChangeNotifier();
  }
  void studentLogOut({required context}){
    _studentData.name = '';
    _studentData.isLoggedIn = false;
    Provider.of<FinishedQuizProvider>(context).quizzesListClear;
    ChangeNotifier();
  }
}