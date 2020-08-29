import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;

  List<Question> _questionBank = [
    Question(
        q: '\'A\' is the most common letter used in the English language',
        a: false),
    Question(
        q: 'Bollywood legend Amitabh Bachchan hosted India’s version of Who Wants To Be A Millionaire',
        a: true),
    Question(
        q: 'Earth Rotation is also called annual motion of the earth',
        a: false),
    Question(q: 'The Mahabharata is a part of The Bhagavad Gita', a: false),
    Question(q: '\'Lagaan\' is a science fiction movie', a: false),
    Question(q: 'A woman\'s skin ages faster than a man\'s', a: true),
    Question(q: 'Drinking alcohol lowers the body\'s temperature', a: true),
    Question(q: 'Hair and nails continue to grow even after death', a: false),
    Question(
        q: 'A man\'s brain is biologically bigger than a woman\'s', a: true),
    Question(
        q: 'No piece of square dry paper can be folded in half more than 7 times.',
        a: false),
    Question(
        q: 'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        a: false),
    Question(
        q: 'The total surface area of two human lungs is approximately 70 square metres.',
        a: true),
    Question(q: 'Google was originally called \"Backrub\".', a: true),
    Question(
        q: 'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        a: true),
  ];

  String getQuestionText() {
    //if (isFinished()) reset();
    if (_questionNumber < _questionBank.length)
      return _questionBank[_questionNumber].questionText;
    return "";
  }

  bool getQuestionAnswer() {
    //if (isFinished()) reset();
    if (_questionNumber < _questionBank.length)
      return _questionBank[_questionNumber].questionAnswer;
    return false;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length) _questionNumber++;
  }

  bool isFinished() {
    if (_questionNumber == _questionBank.length) return true;
    return false;
  }

  void reset() {
    _questionNumber = 0;
    _score = 0;
  }

  void scoreUp() {
    _score++;
  }

  int getScore() {
    return _score;
  }

  bool isLast() {
    if (_questionNumber == _questionBank.length - 1) return true;
    return false;
  }
}
