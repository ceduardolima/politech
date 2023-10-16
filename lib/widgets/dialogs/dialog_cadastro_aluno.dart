import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:politech/widgets/dialogs/dialog_botao_unico.dart';

import '../../domain/aluno/aluno.dart';

class DialogCadastroAluno extends StatelessWidget {
  DialogCadastroAluno({super.key, required this.confirmar, required this.turmaId});
  final _chaveCriarAluno = GlobalKey<FormBuilderState>();
  final Function(Aluno) confirmar;
  final String turmaId;

  Aluno? _obterAluno() {
    final estado = _chaveCriarAluno.currentState;
    if (estado != null && estado.saveAndValidate()) {
      return Aluno.genId(
        estado.fields["nome"]!.value!,
        turmaId
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogBotaoUnico(
      titulo: "Cadastro do aluno",
      confirmar: () {
        final aluno = _obterAluno();
        if (aluno != null) {
          confirmar(aluno);
          Navigator.pop(context);
        }
      },
      fecharDialog: () => Navigator.pop(context),
      filho: FormBuilder(
        key: _chaveCriarAluno,
        child: Column(
          children: [
            FormBuilderTextField(
              name: "nome",
              maxLines: 1,
              maxLength: 50,
              decoration:
                  const InputDecoration(labelText: 'Nome', helperText: ""),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campor obrigatório"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
