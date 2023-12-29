//gerenciar o store dos produtos

import 'package:flutter/material.dart';

import 'package:flutter_value_notifier_flutterando/src/product/product_service.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_state.dart';

//espramos uma lista d produtos model, entao colocar o <>

//isso tudo vai ser nossa reatividade

/*
Antes, a store retornava logo a lista de produtos,
como se fosse certo que a requisição seria um sucesso.
Mas usaremos o padrão state. Vai retornar o ProductState,
que é o pai de todos aqueles estados diferentes.

Então a partir daí, o value dessa classe, que iremos atualizar, 
não será mais do tipo List<ProductModel>, mas sim do ProductState.*/

/*class ProductStore extends ValueNotifier<List<ProductModel>> {
  final ProductService service;
  ProductStore(this.service) : super([]);

  Future fetchProducts() async {
    final products = await service.fetchProducts();

//esse value é do tipo List<ProductModel>. ao adicionarmos o products nele, acontece a reatividad
    value = products;
  }
}*/

/*então, o estado inicial não vai ser mais uma lista vazia,
vai ser o próprio estado inicial, que lá dentro, tá configurado 
tambem que é uma lista vazia - InitialProductState é um ProductState,
por isso pode ser retornado, viva a OO. */

class ProductController extends ValueNotifier<ProductState> {
  final ProductService service;
  ProductController(this.service) : super(InitialProductState());

  Future fetchProducts() async {
    //ta vendo como é só pra gerenciar o estado? é pra colocar os estados assim em cada parte
    value = LoadingProductState();
    //p ver o loading, pois como o bagulho é local(tamo testando), nao demora p pegar como dmoraria na internet.
    await Future.delayed(const Duration(seconds: 1));
    try {
      final products = await service.fetchProducts();
      //se for sucesso, retorna a classe de sucesso, que tem a propriedade products
      value = SuccessProductState(products);
    } catch (e) {
      //se for erro, retorna a classe de erro, que precisa de uma msg
      value = ErrorProductState(e.toString());
    }
  }
}
