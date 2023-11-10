import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({super.key});

  @override
  State<TelaPedidos> createState() => _telaPedidosState();
}

class _telaPedidosState extends State<TelaPedidos> {
  @override
  Widget build(BuildContext context) {

    criarConteudo() {
        return const Row(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                ImagemTexto(
                  imagePath:
                    'https://cdn.pixabay.com/photo/2019/02/21/19/00/restaurant-4011989_1280.jpg',
                  text1: 'Rodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                  text2: '1 - X-Salada', 
                  ),
              
              ],
            ),
          ],
        );
    }
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 241, 214),
    body: criarConteudo(),
    appBar: AppBar(title: const Text('PEDIDOS', style: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 109, 107, 107)  
    ),),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 167, 167, 133),
    ),   
    );
  }
}