import 'package:flutter/material.dart';
import '../../components/Widgets/CustomAppBar.dart';
import '../../components/Widgets/GrediantBoxWidget.dart';
import 'StudentLoginView.dart';
import 'TeacherLogin.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _currentIndex = 0;

  // Define the content for each tab
  final List<Widget> _tabs = [
    const TeacherLoginView(),
    const StudentLoginView(),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenWidth = mediaQueryData.size.width;


    return SafeArea(
      child: Scaffold(
        body: GradientBoxWidget(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //    SizedBox(height: 25,),
                Row(
                  children: <Widget>[
                    buildTabItem(0, 'Teacher'),
                    buildTabItem(1, 'Student'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.9)),
                  height: 4,
                  width: screenWidth * .7,
                ),
                CustomAppBar(
                  ShowIcons: false,
                  isBigLogo: true,
                ),
                const Text('Welcome Back!', style: TextStyle(
                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.2)),
                  height: 2,
                  width: 220,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _tabs[_currentIndex],
                ), // Display the selected tab's content
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(int index, String text) {
    return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _currentIndex == index ? const Color(0xff5D12D2).withOpacity(0.8) : const Color(0xff5D12D2).withOpacity(0.5),
              ),
              alignment: Alignment.center,
              height: 50.0,
              child: Text(
                text,
                style: TextStyle(
                  color: _currentIndex == index ? Colors.white : Colors.white,
                  fontSize: 18,
                  decoration: _currentIndex == index ? TextDecoration.underline:TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  }
}
