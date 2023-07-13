import 'package:flutter/material.dart';
import 'package:questionmakermobile/widgets/mainscreenwidgets.dart';

void main() {
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
  String _lastName = "", _patientCode = "";

  void _check4Child() {

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
          child: Column(
            children: [
              const SizedBox(height: 60,),
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
                onSaved: (value) {
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
                  if (value == null || value.isEmpty || value.length != 40) {
                    return 'Invalid patient code detected';
                  }
                  return null;
                },
                onSaved: (value) {
                  _patientCode = value!;
                },
              ),
              const SizedBox(height: 75,),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: _check4Child,
                  child: const Text("Submit"),
                )
              )
            ],
          )
        ),
      )
    );
  }

}