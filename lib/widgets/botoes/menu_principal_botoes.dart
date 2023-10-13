import 'package:flutter/material.dart';
import 'package:politech/theme/colors_theme.dart';

class MeuPrincipalBotao extends StatelessWidget {
  const MeuPrincipalBotao({super.key, required this.onClick, required this.titulo, required this.icone});
  final Function() onClick;
  final String titulo;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icone,
              size: 70,
              color: ColorsTheme().lightColorsScheme().primaryContainer,
            ),
            Text(titulo, style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
