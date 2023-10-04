import 'package:flutter/material.dart';
import 'package:politech/domain/chamada/chamada.dart';
import 'package:politech/theme/colors_theme.dart';

class ChamadaItemLista extends StatelessWidget {
  const ChamadaItemLista({
    super.key,
    required this.chamada,
    required this.onPressed,
    required this.onDelete,
  });

  final Chamada chamada;
  final Function() onPressed;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.centerLeft,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chamada de ${chamada.data.day}/${chamada.data.month}/${chamada.data.year}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete,
                      color: ColorsTheme().lightColorsScheme().secondary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
