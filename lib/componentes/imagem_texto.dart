import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/modelos/logistica.dart';
import 'package:modulo_logistica_sa/telas/tela_entregas.dart';


// ignore: must_be_immutable
class ImagemTexto extends StatelessWidget {
  Uint8List imagePath;
  String enderecoRestaurante;
  String itemPedido;
  String cliente;
  String nomeRestaurante;
  String enderecoCliente;

 

  ImagemTexto({Key? key, required this.imagePath, required this.enderecoRestaurante, required this.itemPedido, required this.cliente, required this.nomeRestaurante, required this.enderecoCliente})
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
                   Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(imagePath), // Utilize MemoryImage para os bytes da imagem
                          fit: BoxFit.cover,
                        ),
                        ),
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
                       Navigator.of(context).pop();
                       Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (context) => TelaEntregas(
                        enderecoRestaurante: enderecoRestaurante,
                        enderecoCliente: enderecoCliente,
                        nomeRestaurante: nomeRestaurante, 
                        clientes: cliente, 
                        nomesItens: itemPedido, 
                        imagemRestaurantePedido: imagePath, logistica: Logistica('admin','fretefrete','token'),
          // Passe os dados necessários para a próxima tela
                          ),
                        ),
                      );
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
              child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(imagePath), // Utilize MemoryImage para os bytes da imagem
                          fit: BoxFit.cover,
                        ),
                        ),
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