import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';

class BibleVersePageById extends StatefulWidget {
  const BibleVersePageById({super.key});

  @override
  State<BibleVersePageById> createState() => _BibleVersePageByIdState();
}

class _BibleVersePageByIdState extends State<BibleVersePageById> {
  final controller = BibleVerseController(BibleVerseService(DioHttpService()));

  final idEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: idEC,
                ),
              ),
              ElevatedButton(
                  onPressed: () => controller.fetchVerseById(idEC.text),
                  child: const Text('Procurar'))
            ],
          ),
          ValueListenableBuilder<BibleVerseStateStatus>(
            valueListenable: controller,
            builder:
                (BuildContext context, BibleVerseStateStatus state, child) {
              if (state == BibleVerseStateStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state == BibleVerseStateStatus.error) {
                return Center(
                  child: Text(
                      controller.message), // Acesse a mensagem do controlador
                );
              }

              if (state == BibleVerseStateStatus.success) {
                return ListTile(
                  title: Column(
                    children: [
                      Text("ID: ${controller.verse!.id}"),
                      Text("Advice: ${controller.verse!.advice}"),
                    ],
                  ), // Acesse o verso do controlador
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
