//Importacoes de pacotes Flutter e de pacote próprio
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:datp/menu_principal_atualizado/botoes_menu.dart';

//Classe que representa o menu principal do app
class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key}); // Construtor do widget MenuPrincipal

  @override
  State<MenuPrincipal> createState() => _EstadoMenuPrincipal(); // Cria o estado do widget
}

class _EstadoMenuPrincipal extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Cria a estrutura básica da tela
      body: ListView( // Um ScrollView vertical para rolar o conteúdo
        padding: EdgeInsets.zero, // Define o preenchimento do ListView
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // Cor de fundo do tema
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50)), // Borda inferior direita arredondada
            ),
            child: Column(
              children: [
                // Cabeçalho do Menu Principal
                const SizedBox(height: 50), // Espaço vazio
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30), // Preenchimento do ListTile
                  leading: Icon(
                    Icons.sort, // Ícone de classificação
                    color: Colors.white70, // Cor do ícone
                    size: 45, // Tamanho do ícone
                  ),
                  trailing: const CircleAvatar( // Um avatar circular
                    radius: 20, // Raio do avatar
                    backgroundImage: AssetImage('images/avatar.png'), // Imagem do avatar
                  ),
                ),
                // Segunda parte do cabeçalho
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor, // Cor de fundo do tema
            child: Container(
              height: 710, // Altura do container interno
              padding: const EdgeInsets.symmetric(horizontal: 20), // Preenchimento do container interno
              decoration: const BoxDecoration(
                color: Colors.white, // Cor de fundo do container interno
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)), // Borda superior esquerda arredondada
              ),
              child: GridView.count(
                crossAxisCount: 2, // Número de colunas no GridView
                crossAxisSpacing: 40, // Espaçamento horizontal entre os itens
                mainAxisSpacing: 30, // Espaçamento vertical entre os itens
                shrinkWrap: true, // Ocupa apenas o espaço necessário
                physics: const NeverScrollableScrollPhysics(), // Desabilita a rolagem
                children: [
                  itemDashboard('Lista de Presença', AssetImage('images/listadepresenca.png'), Colors.black),
                  itemDashboard('Chamados', AssetImage('images/chamados.png'), Colors.deepOrange),
                  itemDashboard('Minhas Turmas', AssetImage('images/turma.png'), Colors.deepOrange),
                  //itemDashboard('Notificações', AssetImage('images/notificacoes2.png'), Colors.deepOrange), Uso Futuro
                  //itemDashboard('Configurações', AssetImage('images/configuracoes.png'), Colors.deepOrange), Uso Futuro
                  itemDashboard('Feedback', AssetImage('images/feedback.png'), Colors.deepOrange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
