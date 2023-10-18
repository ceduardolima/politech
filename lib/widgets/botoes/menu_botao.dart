import 'package:flutter/material.dart';
import 'package:politech/theme/colors_theme.dart';

class MeuPrincipalBotao extends StatelessWidget {
  const MeuPrincipalBotao({
    super.key,
    required this.onClick,
    required this.titulo,
    this.icone,
    this.imagem,
  });

  final Function() onClick;
  final String titulo;
  final IconData? icone;
  final ImageProvider? imagem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icone == null
                ? ImageIcon(
                    imagem,
                    size: 70,
                    color: ColorsTheme().lightColorsScheme().primaryContainer,
                  )
                : Icon(
                    icone,
                    size: 70,
                    color: ColorsTheme().lightColorsScheme().primaryContainer,
                  ),
            Text(
              titulo,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
