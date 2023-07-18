import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questionmakermobile/models/child.dart';
import 'package:questionmakermobile/widgets/answerscreen.dart';
import 'package:questionmakermobile/widgets/mainscreenwidgets.dart';
import 'package:questionmakermobile/models/answerer.dart';
import 'package:questionmakermobile/data/answerer_enum_data.dart';
import 'package:questionmakermobile/stringextension.dart';

class RelationshipScreen extends StatefulWidget {
  RelationshipScreen(this._childInQuestion, {super.key});

  final Child _childInQuestion;

  @override
  State<RelationshipScreen> createState() => _RelationshipScreenState();
}

class _RelationshipScreenState extends State<RelationshipScreen> {

  bool _submitPressed = false;
  String _lastName = "", _firstName = "";

  late TimeOfInteraction _selectedTimeOfDay;
  late Relationship _selectedRelationship;

  void _submitButtonPressed() {
    setState(() {
      _submitPressed = true;
    });

    _go2AnswerScreen();

    setState(() {
      _submitPressed = false;
    });

  }

  void _go2AnswerScreen() {

    final answerer = Answerer(widget._childInQuestion, _lastName, _firstName,
        _selectedTimeOfDay, _selectedRelationship);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnswerScreen(answerer)
      )
    );

  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relationship to Child"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 15,),
                TextFormField(
                  decoration: const MainScreenTextEntryInputDeco(
                      labelText: "First Name:"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.trim().length <= 1) {
                      return 'Invalid first name detected.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
                const SizedBox(height: 45),
                TextFormField(
                  decoration: const MainScreenTextEntryInputDeco(
                      labelText: "Last Name:"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.trim().length <= 1) {
                      return 'Invalid last name detected';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
                const SizedBox(height: 45,),
                DropdownButtonFormField(
                  items: [
                    for (final category in relationshipCategories.entries)
                      DropdownMenuItem(
                          value: category.key,
                          child: Text(category.value)
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRelationship = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'You must select a relationship category from the options listed';
                    }
                    return null;
                  },
                  decoration: const MainScreenTextEntryInputDeco(
                      labelText: "Relationship to child:"
                  ),
                ),
                const SizedBox(height: 45,),
                DropdownButtonFormField(
                  decoration: const MainScreenTextEntryInputDeco(
                      labelText: "Time that you interact with child:"
                  ),
                  items: [
                    for (final category in TimeOfInteraction.values)
                      DropdownMenuItem(
                          value: category,
                          child: Text(category.name.capitalize())
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTimeOfDay = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'You must select an interaction time from the options listed.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 45,),
                ElevatedButton(
                    onPressed: _submitButtonPressed,
                    child: _submitPressed ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    ) : const Text("Submit")
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
