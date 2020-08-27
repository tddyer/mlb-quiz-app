class Question {

  String question;
  bool answer;

  // constructor
  Question(String q, bool a) { 
    question = q;
    answer = a;
  }

  bool checkAnswer(bool a) {
    if (a == answer)
      return true;
    return false;
  }

}