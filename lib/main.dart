import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questionmakermobile/data/testchild.dart';
import 'package:questionmakermobile/firebase_options.dart';
import 'package:questionmakermobile/widgets/relationshipscreen.dart';
import 'package:questionmakermobile/widgets/mainscreenwidgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/child.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Question Maker',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
            surface: const Color.fromARGB(255, 42, 51, 59),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
        ),
        home: const HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {

  //final lastNameBoxController = TextEditingController()
  final _formkey = GlobalKey<FormState>();

  final CollectionReference _cr = FirebaseFirestore.instance.collection("Patients");
  QueryDocumentSnapshot<Object?>? _foundChild;


  String _lastName = "", _patientCode = "";
  bool _isSending = false;

  Future<void> _submitButtonPressed() async {
    //Firbase logic needs to go here... really all of our logic can go here

    //first we need to check that the app can connect with the firestore database
    //then we need to check for the existence of the child within the database

    //if we find the child, then we need to go to the next screen
    //if not, then there needs to be some kind of error message saying it doesn't exist
    //also need an error message that tells you if the app couldn't connect to the database
    setState(() {
      _isSending = true;
    });

    //_go2RelationshipScreen();
    await getData();

    if (_foundChild != null) {
      //print(_foundChild!.data());
      Child c = createChild();
      print("${c.lastName}\n${c.patientCode}\n${c.questions}");

    } else {

    }

    setState(() {
      _isSending = false;
    });
  }

  Child createChild() {

    // print(_foundChild!.data());
    // var lastName = _foundChild!.get('lastName'),
    // patientCode = _foundChild!.get('patientCode'),
    // qs = _foundChild!.get('Questions');
    // print(qs);

    Child c = Child.fromJson(_foundChild!.data() as Map<String, dynamic>);
    return c;

  }

  Future<void> getData() async {
    //print(_lastName);
    await _cr.where("lastName", isEqualTo: _lastName).where("patientCode", isEqualTo: _patientCode)
        .get().then((value) => {
      if (value.docs.length == 1) {
        _foundChild = value.docs.first
      }
    });

  }

  void _go2RelationshipScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RelationshipScreen(testChild)
      )
    );

  }

  bool _check4Child() {

    return true;

  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Question Maker"),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              TextFormField(
                decoration: const MainScreenTextEntryInputDeco(
                  labelText: "Input Child's Last Name:"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().length <= 1) {
                    return 'Invalid last name detected';
                  }
                  return null;
                },
                onChanged: (value) {
                  _lastName = value!;
                },
              ),
              const SizedBox(height: 75,),
              TextFormField(
                decoration: const MainScreenTextEntryInputDeco(
                  labelText: "Input The Patient Code:",
                  bottomPadding: 40
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty || value.length != 40) {
                  //   return 'Invalid patient code detected';
                  // }
                  return null;
                },
                onChanged: (value) {
                  _patientCode = value!;
                },
              ),
              const SizedBox(height: 75,),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitButtonPressed,
                  child: _isSending ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(),
                  ) : const Text("Submit")
                )
              )
            ],
          )
        ),
      )
    );
  }

}