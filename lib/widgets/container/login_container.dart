import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key, required this.filho, this.botaoVoltar});

  final Widget filho;
  final Widget? botaoVoltar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: ColorsTheme()
                .lightColorsScheme()
                .primaryContainer
                .withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(5, 6),
          ),
        ],
      ),
      width: 350.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: botaoVoltar ??
                const SizedBox(
                  height: 0,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 5.0,
              bottom: 30.0,
            ),
            child: filho,
          ),
        ],
      ),
    );
  }
}
