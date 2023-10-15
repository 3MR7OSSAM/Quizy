import 'package:flutter/material.dart';
import 'CustomAppBar.dart';
class EmptyView extends StatelessWidget {
  const EmptyView({Key? key, required this.title, this.isTeacher}) : super(key: key);
  final String title;
  final bool? isTeacher ;
  @override
  Widget build(BuildContext context) {
    final double height =  MediaQuery.sizeOf(context).height ;
    return Column(
      children: [
        CustomAppBar(
          ShowIcons: true,
          isBigLogo: true,
        ),
        SizedBox(
          height: height * 0.12,
        ),
        Image.asset(
         'assets/images/empty_screen.png',
          width: 250,
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: height* 0.01,
        ),
      //  const GlassNavBar()
      ],
    );
  }
}
