import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: InkWell(
        onTap: (){
          onTap();
        },
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 10,
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16)),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon,color:const Color(0xff5D12D2)),
                  const SizedBox(width: 10,),
                  Text(title ,style: const TextStyle(color:Color(0xff5D12D2,),fontSize: 16),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
