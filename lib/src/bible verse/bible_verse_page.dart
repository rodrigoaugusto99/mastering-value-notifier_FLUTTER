import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';

class BibleVersePage extends StatefulWidget {
  const BibleVersePage({super.key});

  @override
  State<BibleVersePage> createState() => _BibleVersePageState();
}

class _BibleVersePageState extends State<BibleVersePage> {
  final controller = BibleVerseController(BibleVerseService(DioHttpService()));

  @override
  void initState() {
    super.initState();

    controller.fetchRandomVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ValueListenableBuilder<BibleVerseStateStatus>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (state == BibleVerseStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state == BibleVerseStateStatus.error) {
            return Center(
              child:
                  Text(controller.message), // Acesse a mensagem do controlador
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
    );
  }
}
