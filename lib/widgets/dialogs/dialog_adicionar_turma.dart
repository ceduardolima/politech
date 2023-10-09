import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:politech/widgets/dialogs/dialog_botao_unico.dart';

import '../../domain/turma/turma.dart';

class DialogAdicionarTurma extends StatelessWidget {
  DialogAdicionarTurma({super.key, required this.adicionar});

  final _chaveTurma = GlobalKey<FormBuilderState>();
  final Function(Turma) adicionar;

  @override
  Widget build(BuildContext context) {
    return DialogBotaoUnico(
      titulo: "Adicionar Turma",
      filho: FormBuilder(
        key: _chaveTurma,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderTextField(
              name: "nome",
              decoration: const InputDecoration(
                  labelText: 'Nome da Turma', helperText: ""),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campor obrigatório"),
              ]),
            ),
            FormBuilderTextField(
              name: "codigo",
              decoration: const InputDecoration(
                  labelText: 'Código da Turma', helperText: ""),
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(
                      errorText: "Campor obrigatório"),
                ],
              ),
            ),
          ],
        ),
      ),
      confirmar: () async {
        final estado = _chaveTurma.currentState;
        if (estado != null && estado.saveAndValidate()) {
          final turma = Turma.genId(
            estado.fields["nome"]!.value!.toString().toUpperCase(),
            estado.fields["codigo"]!.value!.toString().toUpperCase(),
          );
          adicionar(turma);
        }
      },
      fecharDialog: () => Navigator.of(context).pop()
    );
  }
}
