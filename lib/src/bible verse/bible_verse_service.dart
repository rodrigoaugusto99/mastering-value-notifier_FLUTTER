//pr consumir a api qui dntro
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/bible%20verse/bible_verse_model.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_model.dart';
import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';

class BibleVerseService {
  final IHttpService client;

  BibleVerseService(this.client);

//pra pegar, temos que fazer o modelo antes
  Future<BibleVerseModel> getRandommVerse() async {
    final response = await client.get('https://api.adviceslip.com/advice');
    log(response.toString());
    //return BibleVerseModel.fromMap(response.data['slip']);

    //final jsonResponse = response.data;
/*temos que usar o fromJson pois o json não é um mapa direto,
pois há um JSON tem uma estrutura mais complexa com um objeto "slip" 
encapsulando as propriedades, é necessário usar o json.decode para 
obter esse Map antes de acessar as propriedades específicas.
*/
/*
ou seja, eu poderia usar o fromMap, mas antes teria que fazer um json
decode (exemplo no getVerseById), que transforma a estrutura json 
em um Map<String, dynamic>
 */
    final bibleVerse = BibleVerseModel.fromJson(response.data);

    return bibleVerse;
  }

  Future<BibleVerseModel> getVerseById(String id) async {
    final response = await client.get('https://api.adviceslip.com/advice/$id');

    final jsonResponse = json.decode(response.data);

    final bibleVerse = BibleVerseModel.fromMap(jsonResponse);

    return bibleVerse;
  }
}
