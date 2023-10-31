import 'package:flutter/material.dart';

class DialogBotaoUnico extends StatelessWidget {
  const DialogBotaoUnico({
    super.key,
    required this.titulo,
    this.label,
    required this.confirmar,
    required this.fecharDialog,
    required this.filho,
  });

  final Widget filho;
  final String? label;
  final String titulo;
  final Function() confirmar;
  final Function() fecharDialog;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 6),
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 3),
                IconButton(
                  onPressed: fecharDialog,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: filho,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: confirmar,
              child: Text(label ?? "CONFIRMAR"),
            )
          ],
        ),
      ),
    );
  }
}
