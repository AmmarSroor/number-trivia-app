import 'package:first_project/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade800,
        accentColor: Colors.blueGrey.shade600
      ),
      home: NumberTriviaPage(),
    );
  }
}
