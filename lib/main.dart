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
  bool correct = false;
  bool _visible = false;
  
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
            child: Center(
              child: Text(
                quizLogic.questionList[questionNum % quizLogic.questionList.length].question,
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
          child: Center(
            child: getIcon(correct),
          ),
        ),
        Expanded(
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
                setState(
                  () {
                    if (quizLogic.questionList[questionNum % quizLogic.questionList.length].checkAnswer(true))
                      correct = true;
                    else 
                      correct = false;

                    _visible = true;
                    questionNum++;
                  }
                );
              },
            ),
          ),
        ),
        Expanded(
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
                setState(
                  () {
                    if (quizLogic.questionList[questionNum % quizLogic.questionList.length].checkAnswer(false))
                      correct = true;
                    else 
                      correct = false;
  
                    _visible = true;
                    questionNum++;
                  }
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
