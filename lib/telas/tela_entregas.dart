import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/modelos/pedidos.dart';


// ignore: must_be_immutable
class TelaEntregas extends StatelessWidget {
Pedidos pedidos = Pedidos.inciar();

  dynamic imagePath = "asodsaojkdsa";
  dynamic endereco =  "casads coad sadcara";
  dynamic qntItemPedido = "128312470214821";
  dynamic itemPedido = "sexo 2";
  dynamic cliente = "jorge";




  TelaEntregas({super.key, 
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
      body: criarConteudo(),
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
            ],
          ),
        ),
          ),
        )  
      ),
      );
  }
}