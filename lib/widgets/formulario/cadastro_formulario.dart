import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CadastroFomulario extends StatelessWidget {
  const CadastroFomulario({
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
              FormBuilderValidators.email(errorText: "Email inválido"),
              (value) {
                final estado = chaveCadastro.currentState;
                if (estado != null) {
                  if (estado.fields["email"]!.value != value) {
                    return "Os emails precisam ser iguais";
                  }
                }
                return null;
              }
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
              (value) {
                final estado = chaveCadastro.currentState;
                if (estado != null) {
                  if (estado.fields["senha"]!.value != value) {
                    return "As senhas precisam ser iguais";
                  }
                }
                return null;
              }
            ]),
          ),
        ],
      ),
    );
  }
}
