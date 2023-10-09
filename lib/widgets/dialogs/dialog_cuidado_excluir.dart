import 'package:flutter/material.dart';
import 'package:politech/theme/colors_theme.dart';

class DialogCuidadoExcluir extends StatelessWidget {
  const DialogCuidadoExcluir({super.key, required this.excluir});
  final Function() excluir;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color:
            ColorsTheme().lightColorsScheme().secondary,
          ),
          const SizedBox(width: 15),
          const Text("Cuidado"),
        ],
      ),
      content: const Text(
          "Excluindo uma turma, você também excluirá todas as"
              " chamadas feitas até o momento.\n\n"
              "Tem certeza que deseja excluir a turma?"),
      actions: [
        ElevatedButton(
          onPressed:() {
            excluir();
            Navigator.pop(context);
          },
          child: Text("Excluir"),
          style: ElevatedButton.styleFrom(
            backgroundColor:
            ColorsTheme().lightColorsScheme().secondary,
          ),
        ),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar")),
      ],
    );;
  }
}
