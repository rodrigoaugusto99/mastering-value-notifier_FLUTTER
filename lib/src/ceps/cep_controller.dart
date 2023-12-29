import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_model.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';

enum CepStateStatus { initial, loading, success, error }

class CepController extends ValueNotifier<CepStateStatus> {
  final CepService service;
  CepController(this.service) : super(CepStateStatus.initial);

  AddressModel? address;
  List<AddressModel> addressList = [];
  String cep = '';
  String message = '';

  Future fetchAddressByCep(String cep) async {
    value = CepStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      address = await service.getAddress(cep);
      if (address!.cep == '') {
        value = CepStateStatus.error;
        message = 'Não existe endereço para esse CEP';
      } else {
        value = CepStateStatus.success;
      }
    } catch (e) {
      value = CepStateStatus.error;
      message = e.toString();
      log(message);
    }
  }

  Future fetchCep(String logradouro, String localidade, String uf) async {
    value = CepStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await service.getCep(logradouro, localidade, uf);
      if (result == '') {
        value = CepStateStatus.error;
        message = 'Não existe CEP correspondente';
      } else {
        cep = result;
        value = CepStateStatus.success;
      }
    } catch (e) {
      value = CepStateStatus.error;
      message = e.toString();
      log(message);
    }
  }

  Future fetchCepAndMore(
      String logradouro, String localidade, String uf) async {
    value = CepStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await service.getCepAndMore(logradouro, localidade, uf);
      if (result.cep == '') {
        value = CepStateStatus.error;
        message = 'Não existe endereço para esses dados';
      } else {
        address = result;
        value = CepStateStatus.success;
      }
    } catch (e) {
      value = CepStateStatus.error;
      message = e.toString();
      log(message);
    }
  }

  Future fetchAllCepAndMore(
      String logradouro, String localidade, String uf) async {
    value = CepStateStatus.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await service.getAllCepAndMore(logradouro, localidade, uf);
      if (result.first.cep == '') {
        value = CepStateStatus.error;
        message = 'Não existe endereço para esses dados';
      } else {
        addressList = result;
        value = CepStateStatus.success;
      }
    } catch (e) {
      value = CepStateStatus.error;
      message = e.toString();
      log(message);
    }
  }
}

/*repare que eu brinco com os valores de status e com os valores das mensagens
tipo, seguiu o fluxo certinho, veio um address.
seria success, né? mas antes eu faço outra verificação, e vejo se
o cep nao está vazio, e se estiver, eu coloco um status.error e adiciono uma mensagem.
Lá na page, eu coloco que, se o status for de error, a mensagem que eu coloqui aqui
no controller será exibida.
 */

/*
repare tambem que aquela programacao funcional com Either,
faz com que apenas tenha apenas try catchs lá no repositorio, as mensagenms 
stão apenas lá, e em todo lugar que eu for, nao vai ter exception, 
vai ter apenas case Success e Failure (left and right)
 */

/*
repare que é sempre a mesma logica, nós decidismos qual é o status e no mesmo fluxo a gente
determina um valor por exemplo do address ou da mensagem de erro,realmente la na page
basta ser exibido as coisas com base no estado do controller.

fizemos assim agora com value notifier
fizmos assim com riverpod la no barbershop

 */