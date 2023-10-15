import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FinishedQuizWidget extends StatelessWidget {
   FinishedQuizWidget({Key? key, required this.percentage, required this.date, required this.subject}) : super(key: key);
   double percentage;
  final String date;
  final String subject;

  @override
   Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context); // Only get MediaQueryData once.
    double screenHeight = mediaQueryData.size.height;
     String stringScore = percentage.toStringAsFixed(2);
     percentage = double.parse(stringScore);
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
       child: Container(
         height: screenHeight*0.1,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(16),
             color: Colors.white
         ),
         child: ListTile(
           title: Text(subject),
           subtitle: Text('Date :$date'),
           trailing: FittedBox(
             child: CircularPercentIndicator(
               radius: 45.0,
               lineWidth: 12.0,
               animation: true,
               percent: percentage,
               center: Text(
                 "${percentage*100}%",
                 style:
                 TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: percentage*100<50 ? Colors.red:Colors.green),
               ),
               circularStrokeCap: CircularStrokeCap.butt,
               progressColor: percentage*100<50 ? Colors.red.withOpacity(0.75):Colors.green.withOpacity(0.75),
             ),
           ),

         ),
       ),
     );
   }
}
