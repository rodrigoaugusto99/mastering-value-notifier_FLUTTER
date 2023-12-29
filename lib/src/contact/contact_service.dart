//pr consumir a api qui dntro

import 'package:flutter_value_notifier_flutterando/src/contact/contact_model.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_model.dart';
import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';
import 'package:uno/uno.dart';

class ContactService {
  final IHttpService client;

  ContactService(this.client);

//pra pegar, temos que fazer o modelo antes
  Future<List<ContactModel>> fetchProducts() async {
    final response = await client.get('http://10.0.2.2:3031/contacts');

    //transformar response no productmodel
    //sem as List, ele fica dynamic
    //List pra poder usar as propriedades de lista nele.
    final list = response.data as List;
//map - transformando item a item em um product model
    /*final products = list
        .map((e) => ProductModel(
              id: e['id'],
              title: e['title'],
            ))
        .toList();*/
    final contacts = list.map((e) => ContactModel.fromMap(e)).toList();

    return contacts;
  }
}
