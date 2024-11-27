import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

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
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

void checkedAnswer(bool pickedAnswer) {
  setState(() {
    if (quizBrain.isFinished()) {
    
      
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You\'ve reached the end of the quiz.',
        buttons: [
          DialogButton(
            child: Text(
              "Try again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              quizBrain.reset(); // Reset the quiz or any necessary state
              scoreKeeper.clear(); // Clear scoreKeeper for a new attempt
              setState(() {}); // Refresh the UI
            },
          ),
        ],
      ).show();
    } else {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if (pickedAnswer == correctAnswer) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizBrain.nextQuestion(); // Move to the next question
    }
  });
}

  // List <String> questions =[
  //   'Approximately one quarter of human bones are in the feet.',
  //    'A slug\'s blood is green.'
  // ];
  // List <bool> answers=[
  //    false,
  //    true,
  //    true,
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(
              10.0,
            ),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () {
              checkedAnswer(true);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: const Text(
              'True',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () {
              checkedAnswer(false);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: const Text(
              'False',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
