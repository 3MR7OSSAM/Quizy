import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Views/splashView/splashView.dart';
import 'components/Providers/AddQuizProvider.dart';
import 'components/Providers/FinishedQuizProvider.dart';
import 'components/Providers/QuizProvider.dart';
import 'components/Providers/StudentProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}


final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(home: Scaffold(
              body: Center(child: CircularProgressIndicator(),),),);
          } else if (snapshot.hasError) {
            return const MaterialApp(home: Scaffold(
              body: Center(child: Text('There is an error'),),),);
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return QuizProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return FinishedQuizProvider();
              }), ChangeNotifierProvider(create: (_) {
                return StudentProvider();
              }), ChangeNotifierProvider(create: (_) {
                return AddQuizProvider();
              }),
            ],
            child: MaterialApp(

              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  fontFamily: 'Mooli',
                  primarySwatch: Colors.purple
              ),
              title: 'Quizy',
              home:  const SplashView(),
            ),
          );
        }
    );
  }
}
