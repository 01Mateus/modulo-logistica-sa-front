import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';


class TelaEntregas extends StatelessWidget {
   dynamic imagePath;
   dynamic endereco;
   dynamic qntItemPedido;
   dynamic itemPedido;
   dynamic cliente;
   dynamic nomeRestaurante;

  TelaEntregas({ 
    required this.imagePath,
    required this.endereco,
    required this.qntItemPedido,
    required this.itemPedido,
    required this.cliente,
    required this.nomeRestaurante,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entregas',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 106, 109)
              ),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
      ),
      body: criarConteudo(),
      backgroundColor: const Color.fromARGB(255, 236, 241, 214),
    );
  }

  criarConteudo() {
      return Center(
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(imagePath),
              ),
              const SizedBox(height: 10),
              Text(
                endereco,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Text(
                '\nPedido:',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                qntItemPedido,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                itemPedido,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                'Cliente:',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                cliente,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
               Text(
                nomeRestaurante,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
               Builder(
                builder: (BuildContext context) {
                  return Botao(
                          texto: 'Finalizar entrega',
                          funcao: () {
                            Navigator.of(context).pop('/pedidos');
                          },
                          cor: Colors.blue,
                          icone: Icons.check,
                  );
                }),
            ],
          ),
        ),
          ),
        )  
      ),
      );
  }
}