import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  int rightAnswer;
  int allAnswer;

  ResultPage({@required this.rightAnswer, @required this.allAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),
      body: Center(
        child: Text(
            "Your answered correct: ${rightAnswer} questions\nOver ${allAnswer} questions",textAlign: TextAlign.center,
          style:TextStyle(color: Colors.white,fontSize: 24) ,),
      ),
    );
  }
}
