import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_model.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';

class CepControllerChangeNotifier extends ChangeNotifier {
  final CepService service;
  CepControllerChangeNotifier(this.service);

  AddressModel _address =
      AddressModel(bairro: '', cep: '', localidade: '', logradouro: '', uf: '');

  AddressModel getAddress() => _address;

  String _message = '';
  String? getMessage() => _message;

  Future fetchAddressByCep(String cep) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      _address = await service.getAddress(cep);
      if (_address.cep == '') {
        _message = 'Não existe endereço para esse CEP';
      } else {}
    } catch (e) {
      _message = e.toString();
      log(_message);
    }
    notifyListeners();
  }

  /*-----testando valueNotifier simples-----*/

  final ValueNotifier<int> _valor = ValueNotifier<int>(0);

  ValueNotifier<int> get valor => _valor;

  void incrementar() {
    _valor.value++;
  }
}
