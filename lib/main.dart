import 'package:flutter/material.dart';
import 'package:quizzler/quizBrain.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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
  void playCorrectSound() {
    final player = AudioCache();
    player.play('correct.mp3');
  }

  void playIncorrectSound() {
    final player = AudioCache();
    player.play('incorrect.mp3');
  }

  void showCorrectAlert() {
    if (quizBrain.isLast()) {
      int finalScore = quizBrain.getScore();
      Alert(
        context: context,
        type: AlertType.success,
        title: "Correct!",
        desc: "Your Final Score: $finalScore",
        buttons: [
          DialogButton(
            child: Text(
              "Finish Quiz",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 200,
          )
        ],
      ).show();
      quizBrain.reset();
      scoreKeeper.clear();
    } else {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Correct!",
        desc: "You're awesome",
        buttons: [
          DialogButton(
            child: Text(
              "Next Question",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 200,
          )
        ],
      ).show();
      quizBrain.nextQuestion();
    }
  }

  void showIncorrectAlert() {
    if (quizBrain.isLast()) {
      int finalScore = quizBrain.getScore();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Incorrect!",
        desc: "Your Final Score: $finalScore",
        buttons: [
          DialogButton(
            child: Text(
              "Finish Quiz",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 200,
          )
        ],
      ).show();
      quizBrain.reset();
      scoreKeeper.clear();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Incorrect!",
        desc: "Bad Luck!",
        buttons: [
          DialogButton(
            child: Text(
              "Next Question",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 200,
          )
        ],
      ).show();
      quizBrain.nextQuestion();
    }
  }

  // void endAlert() {
  //   int finalScore = quizBrain.getScore();
  //   Alert(
  //     context: context,
  //     title: "Quiz Finished",
  //     desc: "Your final score: $finalScore",
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "Cancel",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         //onPressed: () => Navigator.pop(context),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         width: 120,
  //       )
  //     ],
  //   ).show();
  //   quizBrain.reset();
  //   scoreKeeper.clear();
  // }

  Icon correct = Icon(
    Icons.check,
    color: Colors.green,
  );

  Icon incorrect = Icon(
    Icons.clear,
    color: Colors.red,
  );

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    setState(() {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if (correctAnswer == userAnswer) {
        scoreKeeper.add(correct);
        playCorrectSound();
        quizBrain.scoreUp();
        showCorrectAlert();
      } else {
        scoreKeeper.add(incorrect);
        playIncorrectSound();
        showIncorrectAlert();
      }
    });
  }

  int currentScore = 0;
  @override
  Widget build(BuildContext context) {
    currentScore = quizBrain.getScore();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              'Score: $currentScore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontFamily: 'CaveatBrush',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'CaveatBrush',
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'CaveatBrush',
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'CaveatBrush',
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
