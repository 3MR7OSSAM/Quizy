import 'package:flutter/material.dart';

import 'btm_alert.dart';
Future<void> showAlertDialog(
    {required context,
      required TextEditingController subjectController,
      required Function(String)? onChanged,
      required Function onContinue,
     required String title,
     required String subTitle,

    }) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text(title),
          content: TextField(
            onChanged: onChanged,
            controller: subjectController,
            maxLines: 1,
            decoration:  InputDecoration(
              helperText: subTitle,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
         //   Spacer(),
            TextButton(
              onPressed: () async{
                if(subjectController.text != ""){
                  Navigator.pop(context);
                  onContinue();
                }else {
                  showBtmAlert(context, 'Subject can\'t be empty !');
                }
              },
              child: const Text('Continue'),
            ),


          ],
        );
      });
}
