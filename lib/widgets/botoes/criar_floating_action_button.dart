import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

class CriarFloatActionButton extends StatelessWidget {
  const CriarFloatActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
        backgroundColor: ColorsTheme().lightColorsScheme().secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
