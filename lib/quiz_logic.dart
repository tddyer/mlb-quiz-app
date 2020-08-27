import 'question.dart';

// using this modular approach, you could create multiple quiz_logic type files
// to have multiple different kinds of quizzes

class QuizLogic {

  // this will end up being populated with info from parsed player stats
  List<Question> _questionList = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
  ];

  String getQuestionText(int questionNum) {
    return _questionList[questionNum % _questionList.length].question;
  }


  bool checkAnswer(int questionNum, bool a) {
    if (a == _questionList[questionNum % _questionList.length].answer)
      return true;
    return false;
  }

}