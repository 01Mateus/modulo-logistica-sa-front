import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';


class ImagemTexto extends StatelessWidget {
  String imagePath;
  String enderecoRestaurante;
  String itemPedido;
  String qntItemPedido;
  String cliente;
  String nomeRestaurante;
  String enderecoCliente;

 

  ImagemTexto({Key? key, required this.imagePath, required this.enderecoRestaurante, required this.itemPedido, required this.cliente, required this.qntItemPedido, required this.nomeRestaurante, required this.enderecoCliente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 178, 185, 185),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                width: 430,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(imagePath.toString()),
                    ),
                   const SizedBox(height: 10),
                    Text(
                      enderecoRestaurante,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const Text(
                      '\nPedido:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      qntItemPedido,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      itemPedido,
                      style: const TextStyle(color: Colors.white, fontSize: 14),   
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Cliente:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      cliente,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      enderecoCliente,
                       style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      nomeRestaurante,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                     Botao(
                      texto: 'Aceitar pedido',
                      funcao: () {
                        Navigator.of(context).pushNamed('/entregas');
                      },
                      cor: Colors.blue,
                      icone: Icons.add,
              ), 
                  ],
                ),
              ),     
            ),
          ),       
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 178, 185, 185),
        ),
        width: 550,
        height: 150,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imagePath),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    enderecoRestaurante,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const Text(
                    '\nPedido:',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    qntItemPedido,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ), 
                  Text(
                    itemPedido,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    nomeRestaurante,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}