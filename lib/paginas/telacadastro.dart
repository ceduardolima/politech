import 'package:flutter/material.dart';
import 'package:politech/paginas/telalogin.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/container/login_container.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: LoginContainer(
          botaoVoltar: IconButton(
            alignment: Alignment.topLeft,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.grey,),
            style: IconButton.styleFrom(alignment: Alignment.centerLeft),
          ),
          filho: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'PoliTech',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Texto em negrito
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nome de Usuário',
                ),
              ),
              const TextField(
                obscureText: true, // Para ocultar a senha enquanto é digitada
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const TextField(
                obscureText: true, // Para ocultar a senha enquanto é digitada
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const TextField(
                obscureText: true, // Para ocultar a senha enquanto é digitada
                decoration: InputDecoration(
                  labelText: 'Confirme o E-mail',
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                child: const Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40)),
                onPressed: () {
                  // Mostrar o texto "Testar banco" ao pressionar o botão
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Testar banco'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Feche o diálogo
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
