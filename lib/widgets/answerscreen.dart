import 'package:flutter/material.dart';
import 'package:questionmakermobile/models/answerer.dart';
import 'package:questionmakermobile/models/child.dart';
import 'package:questionmakermobile/data/answerer_enum_data.dart';


class AnswerScreen extends StatefulWidget {
  AnswerScreen(this._answerer, {super.key});

  Answerer _answerer;

  @override
  State<AnswerScreen> createState() => AnswerScreenState();

}

class AnswerScreenState extends State<AnswerScreen> {

  int _count = 0;
  final List<Answers> _answers = [];
  Answers? _selectedAnswer;

  List<Widget> _buildRadioWidget() {

    List<Widget> widgetList = [];

    for (final category in answerCategories.entries) {
      widgetList.add(
        ListTile(
          title: Text(category.value),
          leading: Radio<Answers> (
            value: category.key,
            groupValue: _selectedAnswer,
            onChanged: (Answers? value) {
              setState(() {
                _selectedAnswer = value;
              });
            },

          ),
        )
      );
      widgetList.add(
        const SizedBox(height: 20,)
      );
    }

    return widgetList;

  }

  void _nextPressed() {
    if (_selectedAnswer != null) {
      _answers.add(_selectedAnswer!);
      // for (final answer in _answers) {
      //   print(answer);
      // }

      if (_count < widget._answerer.childInQuestion.questions.length - 1) {
        setState(() {
          _count++;
          _selectedAnswer = null;
        });
      } else {
        _submitAnswers();
      }

    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Invalid selection"),
            content: const Text("One of the options must be selected to continue."),
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context); },
                  child: const Text("Ok")
              )
            ],
          )
      );
    }

  }

  void _backPressed() {

    setState(() {
      --_count;
      _selectedAnswer = _answers.last;
      _answers.removeLast();
    });

  }

  void _submitAnswers() {
    //This is where we will be making our firebase call and then returning to the main screen
    //TODO: Add in firebase call right here

    Navigator.of(context).popUntil((route) => route.isFirst);

  }

  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Answer Screen") //const Center(child: Text("Answer Screen"),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Form(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Question ${_count + 1}",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: SizedBox(
                  height: 75,
                  child: Text(
                    widget._answerer.childInQuestion.questions[_count],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              //const SizedBox(height: 25,),
              for (final item in _buildRadioWidget())
                item,
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 ElevatedButton(
                     onPressed: (_count == 0) ? () { 
                       Navigator.of(context).pop(); 
                     } : _backPressed,
                     child: const Text("Back")
                 ),
                 const SizedBox(width: 15,),
                 ElevatedButton(
                     onPressed: _nextPressed,
                     child: (_count == widget._answerer.childInQuestion.questions.length - 1) ?
                      const Text("Submit") : const Text("Next")
                 )
               ],
              )
            ],
          ),
        ),
      ),
    );
  }

}