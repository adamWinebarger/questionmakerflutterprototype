import 'package:flutter/material.dart';

class Child {
  Child(this._lastName, this._patientCode, this.questions);

  final String _lastName, _patientCode;
  List<String> questions = [], answers = [];



}