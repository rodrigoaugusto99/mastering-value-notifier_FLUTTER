import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_model.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_service.dart';

enum BibleVerseStateStatus { initial, loading, success, error }

class BibleVerseController extends ValueNotifier<BibleVerseStateStatus> {
  final BibleVerseService service;
  BibleVerseController(this.service) : super(BibleVerseStateStatus.initial);

  BibleVerseModel? verse;
  String message = '';
  Future fetchRandomVerse() async {
    value = BibleVerseStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      verse = await service.getRandommVerse();
      value = BibleVerseStateStatus.success;
    } catch (e) {
      value = BibleVerseStateStatus.error;
      message = e.toString();
      log(message);
    }
  }

  Future fetchVerseById(String id) async {
    value = BibleVerseStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      verse = await service.getVerseById(id);
      value = BibleVerseStateStatus.success;
    } catch (e) {
      value = BibleVerseStateStatus.error;
      message = e.toString();
      log(message);
    }
  }
}
