import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/change%20notifier/cep_controller_change_notifier.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';
import 'package:validatorless/validatorless.dart';

class CepPageTesteChangeNotifier extends StatefulWidget {
  const CepPageTesteChangeNotifier({super.key});

  @override
  State<CepPageTesteChangeNotifier> createState() =>
      _CepPageTesteChangeNotifierState();
}

//? get endereço pelo cep
//? Change notifier com AnimatedBuilder

//?testando valueNotifier simples
//?instanciando ValueNotifier<int> _valor no controller
//?acessando aqui com ValueListenableBuilder com controller.value
//? uso de getter (boa pratica)

class _CepPageTesteChangeNotifierState
    extends State<CepPageTesteChangeNotifier> {
  final controller = CepControllerChangeNotifier(CepService(DioHttpService()));
  final cepEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cep'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) async {
                if (formKey.currentState?.validate() == true) {
                  await controller.fetchAddressByCep(cepEC.text);
                }
              },
              validator: Validatorless.multiple([
                Validatorless.number('Apenas numeros'),
                Validatorless.required('Cep obrigatorio'),
                Validatorless.min(8, '8 digitos por favor'),
                Validatorless.max(8, '8 digitos por favor'),
              ]),
              controller: cepEC,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  await controller.fetchAddressByCep(cepEC.text);
                  if (controller.getAddress().cep == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Esse CEP não existe'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'CEP inválido. Por favor, insira um CEP válido.'),
                    ),
                  );
                }
              },
              child: const Text('Procurar endereço'),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                if (controller.getAddress().cep == '') {
                  return const Center(
                    child: Text('Nao existe esse CEP'),
                  );
                }
                return Column(
                  children: [
                    Text(controller.getAddress().logradouro),
                    Text(controller.getAddress().bairro),
                    Text(controller.getAddress().cep),
                    Text(
                      '${controller.getAddress().localidade} - ${controller.getAddress().uf}',
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.incrementar();
              },
              child: const Text('Incrementar'),
            ),
            ValueListenableBuilder(
              valueListenable: controller.valor,
              builder: (BuildContext context, int valor, Widget? child) {
                return Text('Valor: $valor');
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*aqui, nós instanciamos o controlle igual nas outras vezes.
a diferença é que estou usando o animatedBuilder para reconstruir
os widgets filho caso haja mudanças no seu Listenable(animation).

no caso, estou usando o changeNotifier, e lá eu preciso dar
notifyListeners quando algum valor da classe Controller, ou
em um status do estado(se tiver classe State), etc.
 */