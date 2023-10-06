import 'package:flutter/material.dart';
import 'package:politech/paginas/telacadastro.dart';
import 'package:politech/theme/colors_theme.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().lightColorsScheme().primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: ColorsTheme().lightColorsScheme().primary,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
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
                width: 300.0,
                height: 305.0,
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'PoliTech',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Texto em negrito
                        fontSize: 24,
                      ),
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
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
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
                          child: Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navegar para a TelaCadastro quando o botão "Cadastrar" for pressionado
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TelaCadastro(),
                              ),
                            );
                          },
                          child: Text('Cadastrar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
