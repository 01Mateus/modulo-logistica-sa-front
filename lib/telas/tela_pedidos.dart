import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class telaPedidos extends StatefulWidget {
  const telaPedidos({super.key});

  @override
  State<telaPedidos> createState() => _telaPedidosState();
}

class _telaPedidosState extends State<telaPedidos> {
  @override
  Widget build(BuildContext context) {

    criarConteudo() {
        return const Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                imagemTexto(
                  imagePath:
                    'https://cdn.pixabay.com/photo/2019/02/21/19/00/restaurant-4011989_1280.jpg',
                  text: 'Rodovia SC 441\nRod. Arno Arnaldo Napoli\n248 - Centro, Jaguaruna - SC'
                  ),
                  SizedBox(width: 10),
                  imagemTexto(imagePath: 'https://cdn.pixabay.com/photo/2016/11/18/22/21/restaurant-1837150_1280.jpg', 
                  text: 'Rodovia SC 441\nRod. Arno Arnaldo Napoli\n248 - Centro, Jaguaruna - SC'
                  ),
                  SizedBox(width: 10),
                  imagemTexto(imagePath: 'https://cdn.pixabay.com/photo/2015/02/24/11/54/vienna-647328_1280.jpg', 
                  text: 'Rodovia SC 441\nRod. Arno Arnaldo Napoli\n248 - Centro, Jaguaruna - SC'
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