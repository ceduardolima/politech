import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:politech/paginas/cadastro_pagina.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/container/login_container.dart';
import 'package:politech/paginas/cadastro_turma_pagina.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({Key? key});
  final _chaveLogin = GlobalKey<FormBuilderState>();

  void login() {
    final estadoAtual = _chaveLogin.currentState;
    if (estadoAtual != null) {
      estadoAtual.save();
      String usuario = estadoAtual.value["usuario"];
      String senha = estadoAtual.value["senha"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: LoginContainer(
          filho: FormBuilder(
            key: _chaveLogin,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'PoliTech',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Texto em negrito
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderTextField(
                  name: "usuario",
                  decoration: const InputDecoration(
                    labelText: 'Nome de Usuário',
                  ),
                ),
                FormBuilderTextField(
                  name: "senha",
                  obscureText: true, // Para ocultar a senha enquanto é digitada
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size.fromHeight(40)),
                  onPressed: () {
                    // Mostrar o texto "Testar banco" ao pressionar o botão
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Testar banco'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 16),),
                ),
                const SizedBox(height: 10,),
                TextButton(
                  onPressed: () {
                    // Navegar para a TelaCadastro quando o botão "Cadastrar" for pressionado
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaCadastro(),
                      ),
                    );
                  },
                  child: Text('Realize seu cadastro aqui!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
