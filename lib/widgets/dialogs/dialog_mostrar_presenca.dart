import 'package:flutter/material.dart';

import '../../domain/aluno/aluno.dart';

class DialogMostrarPresenca extends StatelessWidget {
  const DialogMostrarPresenca(
      {super.key, required this.alunos, required this.data});

  final List<Aluno> alunos;
  final String data;

  Widget listarAlunosFaltantes() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: alunos.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      alunos[index].nome,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Center(
                child: Text(
                  "Faltas de $data",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              alunos.isNotEmpty
                  ? listarAlunosFaltantes()
                  : const Expanded(
                      child: Center(
                        child: Text(
                          "Não há faltas",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
