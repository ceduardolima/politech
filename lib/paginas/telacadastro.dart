import 'package:flutter/material.dart';
import 'package:politech/paginas/telalogin.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0), // Opcional: adiciona bordas arredondadas
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Cor da sombra
                  spreadRadius: 0, // Raio de propagação da sombra
                  blurRadius: 7, // Raio de desfoque da sombra
                  offset: Offset(5, 6), // Deslocamento da sombra
                ),
              ],
            ),
            height: 400.0, //Altura desejada
            width: 300.0,
            padding: const EdgeInsets.all(30.0), // Espaçamento interno
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                const SizedBox(height: 20.0),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // Navegar para a TelaCadastro quando o botão "Cadastro" for pressionado
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TelaLogin()),
                        );
                      },
                      child: Text('Login'),
                    ),
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
                                    Navigator.of(context).pop(); // Feche o diálogo
                                  },
                                  child: const Text('Fechar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Cadastrar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}