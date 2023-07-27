import 'package:flutter/material.dart';

class Child {
  Child({required this.lastName, required this.questions, required this.patientCode});

  String path = '';
  final String lastName, patientCode;
  List<dynamic> questions = [];
  List<String>answers = [];

  factory Child.fromJson(Map<String, dynamic> json) =>
      Child(lastName: json['lastName'] as String,
      questions: json['Questions'],
      patientCode: json['patientCode'] as String);

}