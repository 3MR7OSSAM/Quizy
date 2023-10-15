import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key? key,
    required this.ShowIcons,
    required this.isBigLogo,
    this.startIcon,
    this.endIcon,
    this.title,
    this.startIconOnTap,
    this.endIconOnTap,
  }) : super(key: key);

  final bool ShowIcons;
  final Icon? startIcon;
  final Icon? endIcon;
  final String? title;
  final Function()? startIconOnTap; // Corrected function signature
  final Function()? endIconOnTap;   // Corrected function signature
  bool isBigLogo = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenHeight = mediaQueryData.size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (startIconOnTap != null) { // Check if the function is not null
                startIconOnTap!(); // Call the function using "startIconOnTap!()"
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: startIcon ?? Container(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: title == null ? Image.asset(
                'assets/images/app_logo.png',
                width: isBigLogo ? screenHeight * 0.11 : screenHeight * 0.09,
              ):Text(title!,style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
          ),
          InkWell(
            onTap: () {
              if (endIconOnTap != null) { // Check if the function is not null
                endIconOnTap!(); // Call the function using "endIconOnTap!()"
              }
            },
            child: endIcon ?? Container(),
          ),
        ],
      ),
    );
  }
}
