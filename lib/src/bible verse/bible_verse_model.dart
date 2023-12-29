// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BibleVerseModel {
  final String id;
  final String advice;

  BibleVerseModel({
    required this.id,
    required this.advice,
  });

  factory BibleVerseModel.fromMap(Map<String, dynamic> map) {
    final slip = map['slip'];
    return BibleVerseModel(
      id: slip['id'].toString(),
      advice: slip['advice'] ?? '',
    );
  }

  factory BibleVerseModel.fromJson(String source) =>
      BibleVerseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /*ou...
  factory BibleVerseModel.fromJson(String source) {
    final jsonMap = json.decode(source) as Map<String, dynamic>;
    return BibleVerseModel.fromMap(jsonMap);
  } */
}
