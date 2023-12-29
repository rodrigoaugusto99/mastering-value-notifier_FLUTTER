import 'package:flutter/material.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_controller.dart';
import 'package:flutter_value_notifier_flutterando/src/ceps/cep_service.dart';
import 'package:flutter_value_notifier_flutterando/src/services/implementations/dio_http_service.dart';
import 'package:validatorless/validatorless.dart';

class CepPage4 extends StatefulWidget {
  const CepPage4({super.key});

  @override
  State<CepPage4> createState() => _CepPage4State();
}

//? get endereço pelo cep
//?(retornando lista endereços compativeis, carregados
//?automaticamente com onChanged)
//? função para limitar a quantidade de requisicoes
//? ValueNotifier com ValueListenableBuilder

class _CepPage4State extends State<CepPage4> {
  final controller = CepController(CepService(DioHttpService()));
  final logradouroEC = TextEditingController();
  final localidadeEC = TextEditingController();
  final ufEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Adiciona um controlador para limitar as chamadas à API enquanto o usuário digita
  final _debouncer = Debouncer(milliseconds: 500);

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
              onChanged: (value) {
                // Usa o debouncer para limitar as chamadas enquanto o usuário digita
                _debouncer.run(() {
                  fetchCepDataAutomatically();
                });
              },
              validator: Validatorless.multiple([
                //Validatorless.required('Campo obrigatorio'),
                Validatorless.min(3, 'Minimo 3 digitos'),
              ]),
              decoration: const InputDecoration(hintText: 'Logradouro'),
              controller: logradouroEC,
            ),
            TextFormField(
              onChanged: (value) {
                _debouncer.run(() {
                  fetchCepDataAutomatically();
                });
              },
              validator: Validatorless.multiple([
                //Validatorless.required('Campo obrigatorio'),
                Validatorless.min(3, 'Minimo 3 digitos'),
              ]),
              decoration: const InputDecoration(hintText: 'Localidade'),
              controller: localidadeEC,
            ),
            TextFormField(
              onChanged: (value) {
                _debouncer.run(() {
                  fetchCepDataAutomatically();
                });
              },
              validator: Validatorless.multiple([
                //Validatorless.required('Campo obrigatorio'),
                Validatorless.min(2, 'Minimo 2 digitos'),
              ]),
              decoration: const InputDecoration(hintText: 'UF'),
              controller: ufEC,
            ),
            ElevatedButton(
              onPressed: () async {
                // Chama fetchCepData ao pressionar o botão
                if (formKey.currentState?.validate() == true) {
                  await controller.fetchAllCepAndMore(
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
                  if (controller.addressList.isNotEmpty) {
                    // Exibir a lista de endereços
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.addressList.length,
                        itemBuilder: (context, index) {
                          final address = controller.addressList[index];
                          return Column(
                            children: [
                              Text(address.logradouro),
                              Text(address.bairro),
                              Text(address.cep),
                              Text('${address.localidade} - ${address.uf}'),
                              // Adicione outros widgets, se necessário
                              const Divider(), // Adiciona um divisor entre os endereços
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    // Exibir mensagem de lista vazia
                    return const Text('Nenhum endereço encontrado.');
                  }
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

  // Função para chamar fetchAllCepAndMore
  void fetchCepDataAutomatically() async {
    /*se o usuario comçar a digitar, já chama o onChanged 
    para chamar a funcao que retorna o endereço.
    porem, antes disso, os validators sao conferidos.
    sendo assim, quando o usuario começar a digitar um textfield,
    automaticamente já vai aparecer as mensagens de erro
    dos textformfields. Entao a gnt fez com o onChanged chame a verificacao
    apenas quando nao ter chance dos validators ativarem.
    (apenas se for clicado no botao)*/
    if (logradouroEC.text.length >= 3 &&
        localidadeEC.text.length >= 3 &&
        ufEC.text.length == 2) {
      if (formKey.currentState?.validate() == true) {
        await controller.fetchAllCepAndMore(
          logradouroEC.text,
          localidadeEC.text,
          ufEC.text,
        );
      }
    }
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (this.action != null) {
      this.action!();
    }
    this.action = () {
      Future.delayed(Duration(milliseconds: milliseconds), action);
    };
  }
}
