import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/app_bible_verse.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/app_cep.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppCep(),
    );
  }
}
