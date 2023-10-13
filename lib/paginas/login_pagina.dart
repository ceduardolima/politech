import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/container/login_container.dart';
import 'package:politech/widgets/formulario/login_formulario.dart';
import 'package:provider/provider.dart';

import '../domain/usuario/usuario.dart';
import '../servicos/servico_realtime_database.dart';
import '../viewModels/usuario_view_model.dart';
import '../widgets/formulario/cadastro_formulario.dart';

class TelaLogin extends StatefulWidget {
  TelaLogin({Key? key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveLogin = GlobalKey<FormBuilderState>();
  final _chaveCadastro = GlobalKey<FormBuilderState>();
  bool _cadastrando = false;
  bool _carregando = false;
  bool _login = true;

  void login(BuildContext context) async {
    final estadoAtual = _chaveLogin.currentState;
    if (estadoAtual != null) {
      final valido = estadoAtual.saveAndValidate();
      if (valido) {
        String usuario = estadoAtual.fields["usuario"]!.value;
        String senha = estadoAtual.fields["senha"]!.value;
        try {
          setState(() => _carregando = true);
          await context.read<ServicoAutenticacao>().login(usuario, senha);
        } on AuthException catch (e) {
          setState(() => _carregando = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.mensagemErro)));
        }
      }
    }
  }

  void cadastro(BuildContext context) async {
    final estado = _chaveCadastro.currentState;
    if (estado != null) {
      final valido = estado.saveAndValidate();
      if (valido) {
        String nome = estado.fields["usuario"]!.value!;
        String cpf = estado.fields["cpf"]!.value!;
        String email = estado.fields["email"]!.value;
        String validacaoEmail = estado.fields["validacaoEmail"]!.value;
        String senha = estado.fields["senha"]!.value;
        String validacaoSenha = estado.fields["validacaoSenha"]!.value;
        if (validacaoEmail == email && senha == validacaoSenha) {
          try {
            setState(() => _cadastrando = true);
            final autenticacao = context.read<ServicoAutenticacao>();
            await autenticacao.cadastrar(email, senha);
            final Usuario usuario = Usuario(autenticacao.usuario!.uid, cpf, nome, email);
            await context.read<UsuarioViewModel>().inserir(usuario);
            await context.read<ServicoRealTimeDatabase>().criarUsuario(usuario);
          } on AuthException catch (e) {
            setState(() => _cadastrando = false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.mensagemErro)));
          }
        }
      }
    }
  }

  Widget _cadastroBotao(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(50)),
        onPressed: () => cadastro(context),
        child: _cadastrando
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18),
              ),
      );

  Widget _loginBotao(BuildContext context) => ElevatedButton(
        onPressed: () => login(context),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(50),
        ),
        child: _carregando
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: SingleChildScrollView(
          child: LoginContainer(
            botaoVoltar: _login
                ? null
                : IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () => setState(() => _login = true),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                    style: IconButton.styleFrom(alignment: Alignment.centerLeft),
                  ),
            filho: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _login
                    ? LoginFormulario(cadastroChave: _chaveLogin)
                    : CadastroFomulario(chaveCadastro: _chaveCadastro),
                const SizedBox(height: 10),
                _login ? _loginBotao(context) : _cadastroBotao(context),
                const SizedBox(height: 20),
                if (_login)
                  TextButton(
                    onPressed: () => setState(() => _login = false),
                    child: Text("Cadastre-se aqui!"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
