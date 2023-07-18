import 'package:flutter/material.dart';
import 'package:questionmakermobile/models/answerer.dart';
import 'package:questionmakermobile/models/child.dart';


class AnswerScreen extends StatefulWidget {
  AnswerScreen(this._answerer, {super.key});

  Answerer _answerer;

  @override
  State<AnswerScreen> createState() => AnswerScreenState();

}

class AnswerScreenState extends State<AnswerScreen> {


  int _count = 0;
  List<Answers> _answers = [];


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Answer Screen") //const Center(child: Text("Answer Screen"),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
      ),
    );
  }

}