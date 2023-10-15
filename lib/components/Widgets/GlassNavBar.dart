import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class GlassNavBar extends StatelessWidget {
  const GlassNavBar({Key? key, required this.title, required this.profilePage, required this.quizPage}) : super(key: key);
  final String title;
  final Widget profilePage;
  final Widget quizPage;
  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
        borderRadius: BorderRadius.circular(16),
        height: 50,
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  quizPage));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit_note,
                  color: Colors.white.withOpacity(0.7),
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 15,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  profilePage));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white.withOpacity(0.6),
                  size: 28,
                ),
              ),
            ),
          ],
        ));
  }
}
