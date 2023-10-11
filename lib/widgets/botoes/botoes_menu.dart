//Importacoes de pacotes Flutter
import 'package:flutter/material.dart';

// Função para criar um item de dashboard personalizado
Widget itemDashboard(String title, ImageProvider<Object> imageProvider, Color background) {
  return Container(
    // Estilizando o contêiner que envolve o item do dashboard
    decoration: BoxDecoration(
      color: Colors.white, // Cor de fundo branca
      borderRadius: BorderRadius.circular(30), // Borda arredondada com raio de 30
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5), // Deslocamento da sombra
          spreadRadius: 2, // Espalhamento da sombra
          blurRadius: 5, // Desfoque da sombra
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Alinha o conteúdo verticalmente ao centro
      children: [
        Container(
          padding: const EdgeInsets.all(10), // Preenchimento interno
          child: Align(
            alignment: Alignment.center, // Alinha a imagem ao centro horizontal
            child: Image(
              image: imageProvider, // A imagem a ser exibida
              width: 70, // Largura da imagem
            ),
          ),
        ),
        const SizedBox(height: 8), // Espaçamento vertical entre a imagem e o texto
        Text(
          title, // Título passado como parâmetro
          style: TextStyle(
            fontSize: 15, // Tamanho da fonte do texto
            fontWeight: FontWeight.bold, // Estilo de fonte em negrito
          ),
        ),
      ],
    ),
  );
}
