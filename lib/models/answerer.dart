import 'package:questionmakermobile/models/child.dart';

enum TimeOfInteraction {
  morning,
  afternoon,
  both,
  other
}

enum Relationship {
  parentOrGuardian,
  teacher,
  other
}

enum Answers {
  notAtAll,
  sometimes,
  alot,
  always
}

class Answerer {
  Answerer(this.childInQuestion, this.lastName, this.firstName,
      this.timeOfDay, this.relationship);

  Child childInQuestion;
  String lastName, firstName;
  TimeOfInteraction timeOfDay;
  Relationship relationship;



}