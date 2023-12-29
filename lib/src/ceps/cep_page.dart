import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';
import 'package:validatorless/validatorless.dart';

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

//? get endereço pelo cep
//? ValueNotifier com ValueListenableBuilder
class _CepPageState extends State<CepPage> {
  final controller = CepController(CepService(DioHttpService()));
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
                }
              },
              child: const Text('Procurar endereço'),
            ),
            ValueListenableBuilder<CepStateStatus>(
              valueListenable: controller,
              builder: (context, state, child) {
                if (state == CepStateStatus.success) {
                  return Column(
                    children: [
                      Text(controller.address!.logradouro),
                      Text(controller.address!.bairro),
                      Text(controller.address!.cep),
                      Text(
                        '${controller.address!.localidade} - ${controller.address!.uf}',
                      ),
                    ],
                  );
                }
                if (state == CepStateStatus.error) {
                  return Text(controller.message);
                }
                if (state == CepStateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
