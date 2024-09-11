import 'package:flutter/material.dart';
import 'quiez_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper =[];
void checkAnswer(bool userPickedAnswer){
  bool correctAnswer = quizBrain.getCorrectAnswer();
  setState(() {
    if (quizBrain.isFinished() == true) {
      //TODO Step 4 Part A - show an alert using rFlutter_alert,

      //This is the code for the basic alert from the docs for rFlutter Alert:
      //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

      //Modified for our purposes:
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You\'ve reached the end of the quiz.',
      ).show();

      //TODO Step 4 Part C - reset the questionNumber,
      quizBrain.reset();

      //TODO Step 4 Part D - empty out the scoreKeeper.
      scoreKeeper = [];
    }

    if(userPickedAnswer == correctAnswer){
    scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
  }else
  {
    scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
  }

    quizBrain.nextQuestion();
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
                  quizBrain.getQuestionText(),
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
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // background color
                foregroundColor: Colors.white, // text color
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
             checkAnswer(true);

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // background color
                foregroundColor: Colors.white, // text color
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
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