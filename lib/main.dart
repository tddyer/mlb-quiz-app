import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'quiz_logic.dart';

QuizLogic quizLogic = QuizLogic();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int questionNum = 0; // tracks current question - currently goes sequentially through questionList
  bool correct = false; // checks if users answer was correct/incorrect
  bool _visible = false; // determines whether the correct/incorrect icon indicators should be displayed
  int correctAnswerCount = 0; // keeps track of how many questions the user has answered correctly
  int quizLength = quizLogic.getQuizLength();
  
  // takes the users answer and displays the proper icon (correct vs incorrect)
  //  - since _visible is defaulted to false, on the first pass through no icon
  //    will be displayed. Once the user answers, _visible becomes true and the
  //    proper icon will then be displayed breifly
  AnimatedOpacity getIcon(bool correct) {
    return new AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: Icon(
        correct ? Icons.check : Icons.close,
        color: correct ? Colors.green : Colors.red,
        size: 60,
      ),
      onEnd: () {
        setState(() {
          _visible = false;
        });
      }
    );
  }

  // checks user answer, updates appropriate variables based upon answer, and
  // refreshes app state to display answer feedback icon
  void processUserAnswer(bool answer) {
    setState(() {
      // checking user answer
      if (quizLogic.checkAnswer(questionNum, answer)) {
        correct = true;
        correctAnswerCount++;
      } else 
        correct = false;

      // checking if quiz is finished and displaying alert if so
      if (quizLogic.isFinished(questionNum)) {
        Alert(
            context: context,
            title: "Quiz Complete!",
            desc: "You're score: $correctAnswerCount / $quizLength\nYou'll now be redirected to the start of the quiz.")
        .show();
        correctAnswerCount = 0;
      }

      // updating current question number and making answer feedback icon visible
      _visible = true;
      questionNum++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center( // question text
              child: Text(
                quizLogic.getQuestionText(questionNum),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center( // answer feedback icon
            child: getIcon(correct),
          ),
        ),
        Expanded( // true button
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey[800],
                  width: 2.5,
                )
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //true was chosen
                processUserAnswer(true);
              },
            ),
          ),
        ),
        Expanded( // false button
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey[800],
                  width: 2.5,
                )
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () {
                //false was chosen
                processUserAnswer(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}