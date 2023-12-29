import 'dart:developer';

import 'package:flutter_value_notifier_flutterando/src/ceps/cep_model.dart';
import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';

class CepService {
  final IHttpService client;

  CepService(this.client);

  Future<AddressModel> getAddress(String cep) async {
    final response = await client.get('https://viacep.com.br/ws/$cep/json/');
    log(response.toString());
    //return AddressModel.fromMap(response.data);
    //final jsonResponse = response.data;
    final address = AddressModel.fromMap(response.data);

    return address;
    //final jsonResponse = json.decode(response.data);

    //final address = AddressModel.fromMap(jsonResponse);

    // return address;
  }

  Future<String> getCep(String logradouro, String localidade, String uf) async {
    final response = await client
        .get('https://viacep.com.br/ws/$uf/$localidade/$logradouro/json/');

    final mylist = response.data as List;

    final first = mylist.first;

    final address = AddressModel.fromMap(first);
    log(address.cep);
    return address.cep;
  }

  Future<AddressModel> getCepAndMore(
      String logradouro, String localidade, String uf) async {
    final response = await client
        .get('https://viacep.com.br/ws/$uf/$localidade/$logradouro/json/');

    final mylist = response.data as List;

    final first = mylist.first;

    final address = AddressModel.fromMap(first);

    return address;
  }

  Future<List<AddressModel>> getAllCepAndMore(
      String logradouro, String localidade, String uf) async {
    final response = await client
        .get('https://viacep.com.br/ws/$uf/$localidade/$logradouro/json/');

    final myList = response.data as List;
    final List<AddressModel> addressList = [];

    for (final map in myList) {
      final address = AddressModel.fromMap(map);
      addressList.add(address);
    }

    return addressList;
  }
}
