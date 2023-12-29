import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_page.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_page_2.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_page_3.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_page_4.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/change%20notifier/cep_page_teste_change_notifier.dart';

class AppCep extends StatefulWidget {
  const AppCep({super.key});

  @override
  State<AppCep> createState() => _AppCepState();
}

class _AppCepState extends State<AppCep> {
  @override
  Widget build(BuildContext context) {
    void navigateTo(Widget page) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        children: [
          ElevatedButton(
            onPressed: () => navigateTo(const CepPage()),
            child: const Text('Encontre endereço pelo CEP'),
          ),
          ElevatedButton(
            onPressed: () => navigateTo(const CepPage2()),
            child: const Text('Encontre seu CEP'),
          ),
          ElevatedButton(
            onPressed: () => navigateTo(const CepPage3()),
            child: const Text('Encontre seu CEP and more'),
          ),
          ElevatedButton(
            onPressed: () => navigateTo(const CepPage4()),
            child: const Text('Encontre seu CEP and more (lista)'),
          ),
          ElevatedButton(
            onPressed: () => navigateTo(const CepPageTesteChangeNotifier()),
            child: const Text('Testando com change notifier'),
          ),
        ],
      ),
    );
  }
}
