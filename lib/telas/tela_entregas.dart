import 'package:flutter/material.dart';

class TelaEntregas extends StatelessWidget {
  final String imagePath;
  final String endereco;
  final String qntItemPedido;
  final String itemPedido;
  final String cliente;

  TelaEntregas({
    required this.imagePath,
    required this.endereco,
    required this.qntItemPedido,
    required this.itemPedido,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Entregas',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 106, 109)
              ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
      ),
      body: criarCounteudo(),
    );
  }

  criarCounteudo() {
      return Center(
        child:SingleChildScrollView(
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
                radius: 50,
                backgroundImage: NetworkImage(imagePath),
              ),
              SizedBox(height: 10),
              Text(
                endereco,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const Text(
                '\nPedido:',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                qntItemPedido,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                itemPedido,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              SizedBox(height: 10),
              const Text(
                'Cliente:',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                cliente,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
          ),
        )
        
      ),
      );
  }
}