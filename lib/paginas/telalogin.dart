import 'package:flutter/material.dart';
import 'package:politech/paginas/telacadastro.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/container/login_container.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: LoginContainer(
          filho: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size.fromHeight(40)),
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
                              Navigator.of(context).pop();
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Login', style: TextStyle(fontSize: 16),),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  // Navegar para a TelaCadastro quando o botão "Cadastrar" for pressionado
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaCadastro(),
                    ),
                  );
                },
                child: Text('Realize seu cadastro aqui!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
