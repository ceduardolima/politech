import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:politech/domain/usuario/usuario.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/viewModels/usuario_view_model.dart';
import 'package:politech/widgets/container/login_container.dart';
import 'package:provider/provider.dart';

class TelaCadastro extends StatefulWidget {
  TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _chaveCadastro = GlobalKey<FormBuilderState>();

  bool _cadastrando = false;
  late ServicoAutenticacao autenticacao;
  late UsuarioViewModel usuarioViewModel;

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
          Usuario usuario = Usuario.genId(cpf, nome, email);
          try {
            setState(() => _cadastrando = true);
            await autenticacao.cadastrar(usuario, senha);
            await usuarioViewModel.inserir(usuario);
          } on AuthException catch (e) {
            setState(() => _cadastrando = false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.mensagemErro)));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    autenticacao = Provider.of<ServicoAutenticacao>(context);
    usuarioViewModel = context.watch<UsuarioViewModel>();
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: SingleChildScrollView(
          child: LoginContainer(
            botaoVoltar: IconButton(
              alignment: Alignment.topLeft,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              style: IconButton.styleFrom(alignment: Alignment.centerLeft),
            ),
            filho: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _CadastroFomulario(
                  chaveCadastro: _chaveCadastro,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(50)),
                  onPressed: () => cadastro(context),
                  child: _cadastrando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CadastroFomulario extends StatelessWidget {
  const _CadastroFomulario({
    super.key,
    required this.chaveCadastro,
  });

  final GlobalKey<FormBuilderState> chaveCadastro;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: chaveCadastro,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
                labelText: 'Nome de Usuário', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
            ]),
          ),
          FormBuilderTextField(
            name: "cpf",
            decoration: const InputDecoration(labelText: 'Cpf', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
            ]),
          ),
          FormBuilderTextField(
            name: "email",
            decoration:
                const InputDecoration(labelText: 'E-mail', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
              FormBuilderValidators.email(errorText: "Email inválido")
            ]),
          ),
          FormBuilderTextField(
            name: "validacaoEmail",
            decoration: const InputDecoration(
                labelText: 'Confirme o E-mail', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
              FormBuilderValidators.email(errorText: "Email inválido")
            ]),
          ),
          FormBuilderTextField(
            name: "senha",
            obscureText: true, // Para ocultar a senha enquanto é digitada
            decoration:
                const InputDecoration(labelText: 'Senha', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
            ]),
          ),
          FormBuilderTextField(
            name: "validacaoSenha",
            obscureText: true, // Para ocultar a senha enquanto é digitada
            decoration: const InputDecoration(
                labelText: 'Confirmar senha', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
            ]),
          ),
        ],
      ),
    );
  }
}
