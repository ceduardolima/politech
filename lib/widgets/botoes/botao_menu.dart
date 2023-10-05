import 'package:flutter/material.dart';

class BotaoMenu extends StatelessWidget {
  const BotaoMenu({
    super.key,
    required this.onPressed,
    required this.imagem,
    required this.label,
  });

  final Function() onPressed;
  final String imagem;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagem,
                width: 70,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
    );
  }
}
