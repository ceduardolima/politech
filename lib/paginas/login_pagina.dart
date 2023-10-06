import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:politech/paginas/cadastro_pagina.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/container/login_container.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatefulWidget {
  TelaLogin({Key? key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveLogin = GlobalKey<FormBuilderState>();
  bool _carregando = false;

  void login(BuildContext context) async {
    final estadoAtual = _chaveLogin.currentState;
    if (estadoAtual != null) {
      final valido = estadoAtual.saveAndValidate();
      if (valido) {
        String usuario = estadoAtual.fields["usuario"]!.value;
        String senha = estadoAtual.value["senha"]!.value;
        try {
          setState(() => _carregando = true);
          await context.watch<ServicoAutenticacao>().login(usuario, senha);
        } on AuthException catch (e) {
          setState(() => _carregando = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.mensagemErro)));
        }
      }
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
                  decoration:
                      const InputDecoration(labelText: 'Email', helperText: ""),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Campo obrigatorio"),
                    FormBuilderValidators.email(errorText: "Email inválido"),
                  ]),
                ),
                FormBuilderTextField(
                  name: "senha",
                  obscureText: true, // Para ocultar a senha enquanto é digitada
                  decoration:
                      const InputDecoration(labelText: 'Senha', helperText: ""),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Campo obrigatorio"),
                  ]),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(50)),
                  onPressed: () => login(context),
                  child: _carregando
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
