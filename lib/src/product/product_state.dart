/*Antes era só a classe Store com a requisição http e o retorno de List<ProductModel>
Porem,  aquela classe tá acessando a internet. Pode acontecer erro de internet, pode ter laoding.
Precisamos mostrar isso pro usuario, entao pode nao ser uma boa ideia coolocar o retorno da lista logo lá

Padrão state - criar uma class pra cada ESTADO que vamos ter.*
-Teremos uma classe, e essa classe vai originar outros estados. Polimorfismo*/

import 'package:flutter_value_notifier_flutterando/src/product/product_model.dart';

abstract class ProductState {}

/*
-os proximos stados vao surgir a partir dess ProductStat
-vamos ter estado initial, success, error, 
e loading - temos que represntar esses estados em forma de CLASSES
*/

/*-------------- INITIAL ------------------*/
class InitialProductState extends ProductState {}
//InitialProductState também é um ProductState

/*-------------- SUCCESS ------------------*/
/*
uma class pra cada stado,  cada estado ter os componentes 
referente à esse estado - só o success tem product, pois a rquisição deu certo */
class SuccessProductState extends ProductState {
  //é nesse estado que teremos a lista de produtos
  final List<ProductModel> products;

  SuccessProductState(this.products);
}

/*-------------- LOADING ------------------*/
class LoadingProductState extends ProductState {}

/*-------------- ERRO ------------------*/
/*
aqui tem informações - qual erro?
esse estado de erro se modifica, então 
internamente preciso tr pelo menos uma string 
para mensagem p dizer o erro*/
class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState(this.message);
}
