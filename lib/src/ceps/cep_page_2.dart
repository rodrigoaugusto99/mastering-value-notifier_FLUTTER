import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';
import 'package:validatorless/validatorless.dart';

class CepPage2 extends StatefulWidget {
  const CepPage2({super.key});

  @override
  State<CepPage2> createState() => _CepPage2State();
}

//? get cep pelo endereço(log, loc, uf)
//? ValueNotifier com ValueListenableBuilder

class _CepPage2State extends State<CepPage2> {
  final controller = CepController(CepService(DioHttpService()));
  final logradouroEC = TextEditingController();
  final localidadeEC = TextEditingController();
  final ufEC = TextEditingController();
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
                Validatorless.required('Campo obrigatorio'),
                Validatorless.min(3, 'Minimo 3 digitos'),
              ]),
              decoration: const InputDecoration(hintText: 'Logradouro'),
              controller: logradouroEC,
            ),
            TextFormField(
              validator: Validatorless.multiple([
                Validatorless.required('Campo obrigatorio'),
                Validatorless.min(3, 'Minimo 3 digitos'),
              ]),
              decoration: const InputDecoration(hintText: 'Localidade'),
              controller: localidadeEC,
            ),
            TextFormField(
              validator: Validatorless.multiple([
                Validatorless.required('Campo obrigatorio'),
              ]),
              decoration: const InputDecoration(hintText: 'UF'),
              controller: ufEC,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  await controller.fetchCep(
                    logradouroEC.text,
                    localidadeEC.text,
                    ufEC.text,
                  );
                }
              },
              child: const Text('Procurar cep'),
            ),
            ValueListenableBuilder<CepStateStatus>(
              valueListenable: controller,
              builder: (context, state, child) {
                if (state == CepStateStatus.success) {
                  return Text(controller.cep);
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
