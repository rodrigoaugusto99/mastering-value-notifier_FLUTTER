import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_page.dart';
import 'package:flutter_value_notifier_flutterando/src/product/product_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';
import 'package:provider/provider.dart';

class AppProduct extends StatelessWidget {
  const AppProduct({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //3 - ProductService precisa de um IHttpService, entao crio antes
        Provider<IHttpService>(create: (_) => DioHttpService()),
        //2 - então, vamos criar um provider normal do ProductService
        Provider(create: (context) => ProductService(context.read())),
        //1 - ProductController precisa do serviço
        ChangeNotifierProvider(
            create: (context) => ProductController(context.read())),
        //4 - p recuperar os providers acima na arvore, ovbviamente o context.
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductPage(),
      ),
    );
  }
}
