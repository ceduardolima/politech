import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginFormulario extends StatelessWidget {
  const LoginFormulario({super.key, required this.cadastroChave});
  final GlobalKey cadastroChave;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: cadastroChave,
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
            decoration: const InputDecoration(labelText: 'Email', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
              FormBuilderValidators.email(errorText: "Email inválido"),
            ]),
          ),
          FormBuilderTextField(
            name: "senha",
            obscureText: true, // Para ocultar a senha enquanto é digitada
            decoration: const InputDecoration(labelText: 'Senha', helperText: ""),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obrigatorio"),
            ]),
          ),
        ],
      ),
    );
  }
}
