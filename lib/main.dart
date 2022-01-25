import 'package:flutter/material.dart';
import 'package:quizzler/quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text("Quiz"),
          backgroundColor: Colors.grey.shade900,
        ),
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
  List<Icon> scoreKeeper = [];
  int goodAnswers = 0;
  int badAnswers = 0;

  Future<bool> showAlertModal() {
    return Alert(
      context: context,
      title: "Quiz terminé!",
      desc: "Vous avez terminé le quiz. "
          "\n$goodAnswers bonnes réponses. "
          "\n$badAnswers mauvaises réponses. "
          "\nMerci d'avoir joué !.",
      image: Image.asset(
        "images/quiz.png",
        height: 150,
        width: 150,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Start Again",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizzBrain.getQuestionAnswer();

    setState(() {
      if (correctAnswer == userAnswer) {
        goodAnswers++;
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        badAnswers++;
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizzBrain.isFinished()) {
        showAlertModal();
        quizzBrain.reset();
        scoreKeeper.clear();
        goodAnswers = 0;
        badAnswers = 0;
      } else {
        quizzBrain.nextQuestion();
      }
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
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                'VRAI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                });
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                'FAUX',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                });
                //The user picked false.
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
