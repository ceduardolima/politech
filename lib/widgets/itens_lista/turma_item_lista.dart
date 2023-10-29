import 'package:flutter/material.dart';
import 'package:politech/domain/turma/turma.dart';

import '../../theme/colors_theme.dart';

class TurmaItemLista extends StatelessWidget {
  const TurmaItemLista({
    super.key,
    required this.turma,
    required this.excluirTurma,
    required this.onPressed,
  });

  final Turma turma;
  final Function() excluirTurma;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${turma.codigo.toUpperCase()} - ${turma.nome.toUpperCase()}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: ColorsTheme().lightColorsScheme().secondary,
                    ),
                    onPressed: excluirTurma,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.redAccent, // Cor verde para o botão de Editar
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
