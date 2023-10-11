import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/widgets/dialogs/dialog_cadastro_aluno.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../domain/aluno/aluno.dart';
import '../domain/turma/turma.dart';

class CriaTurmaPaginaPagina extends StatefulWidget {
  CriaTurmaPaginaPagina({super.key});

  @override
  State<CriaTurmaPaginaPagina> createState() => _CriaTurmaPaginaPaginaState();
}

class _CriaTurmaPaginaPaginaState extends State<CriaTurmaPaginaPagina> {
  late TurmaViewModel turmaViewModel;
  late AlunoViewModel alunoViewModel;
  final _chaveTurma = GlobalKey<FormBuilderState>();
  final turmaId = const Uuid().v4().toString();
  List<Aluno> alunos = [];
  bool adicionando = false;

  Turma? _obterTurma() {
    final estado = _chaveTurma.currentState;
    if (estado != null && estado.saveAndValidate()) {
      return Turma(
        turmaId,
        estado.fields["nome"]!.value.toString().toUpperCase(),
        estado.fields["codigo"]!.value.toString().toUpperCase(),
      );
    }
    return null;
  }

  void _criarTurma() async {
    final turma = _obterTurma();
    if (turma != null) {
      setState(() => adicionando = true);
      await turmaViewModel.inserir(turma);
      await alunoViewModel.inserirLista(alunos);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    turmaViewModel = context.watch<TurmaViewModel>();
    alunoViewModel = context.watch<AlunoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Turma'),
        backgroundColor: ColorsTheme().lightColorsScheme().primary,
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: _criarTurma,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: adicionando
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Criar turma", style: TextStyle(fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _chaveTurma,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(
                  name: "nome",
                  decoration: const InputDecoration(
                      labelText: 'Nome da Turma', helperText: ""),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Campor obrigatório"),
                  ]),
                ),
                FormBuilderTextField(
                  name: "codigo",
                  decoration: const InputDecoration(
                      labelText: 'Código da Turma', helperText: ""),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText: "Campo obrigatório"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Alunos da turma",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogCadastroAluno(
                        turmaId: turmaId,
                        confirmar: (aluno) =>
                            setState(() => alunos.insert(0, aluno)),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: ColorsTheme().lightColorsScheme().primary,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: alunos.length,
                  itemBuilder: (context, index) {
                    final aluno = alunos[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                          right: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              aluno.nome,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                                onPressed: () =>
                                    setState(() => alunos.removeAt(index)),
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: ColorsTheme()
                                      .lightColorsScheme()
                                      .secondary,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
