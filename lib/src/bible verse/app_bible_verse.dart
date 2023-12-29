import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_page.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_page_by_id.dart';

class AppBibleVerse extends StatelessWidget {
  const AppBibleVerse({super.key});

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
            onPressed: () => navigateTo(const BibleVersePage()),
            child: const Text('Bible Verses'),
          ),
          ElevatedButton(
            onPressed: () => navigateTo(const BibleVersePageById()),
            child: const Text('Bible Verses by Id'),
          ),
        ],
      ),
    );
  }
}
