import 'package:flutter/material.dart';
import 'package:politech/theme/colors_theme.dart';

class DialogCuidado extends StatelessWidget {
  const DialogCuidado({super.key, required this.onClick, required this.texto, required this.textoBotao});
  final String texto;
  final String textoBotao;
  final Function() onClick;
  
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
      content: Text(texto),
      actions: [
        ElevatedButton(
          onPressed:() {
            onClick();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
            ColorsTheme().lightColorsScheme().secondary,
          ),
          child: Text(textoBotao),
        ),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar")),
      ],
    );;
  }
}
