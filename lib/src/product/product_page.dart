import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_state.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_controller.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //?final store = ProductController(ProductService(DioHttpService()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().fetchProducts();
      //?store.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ProductController>();

    final state = store.value;

    Widget? body;

    if (state is LoadingProductState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ErrorProductState) {
      /*quando usamos esse "is", então
            estamos promovendo o state à um ErrorProductState,
            então podemos pegar o message do state*/
      log(state.message);
      body = Center(
        child: Text(state.message),
      );
    }

    if (state is SuccessProductState) {
      body = ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (_, index) {
          final product = state.products[index];
          return ListTile(
            title: Text(product.title),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: body ?? Container(),
    );
  }
}
/*?
ValueListenableBuilder(
        valueListenable: store,
        builder: (BuildContext context, state, child) {
          if (state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorProductState) {
            /*quando usamos esse "is", então
            estamos promovendo o state à um ErrorProductState,
            então podemos pegar o message do state*/
            log(state.message);
            return Center(
              child: Text(state.message),
            );
          }

          if (state is SuccessProductState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (_, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.title),
                );
              },
            );
          }
          return Container();
        },
      ), ?*/