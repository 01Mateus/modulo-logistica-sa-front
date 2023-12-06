// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/modelos/login.dart';
import 'package:modulo_logistica_sa/modelos/logistica.dart';
import 'package:modulo_logistica_sa/telas/tela_entregas.dart';
import 'package:modulo_logistica_sa/telas/tela_login.dart';

// ignore: must_be_immutable
class ImagemTexto extends StatelessWidget {
  Uint8List imagePath;
  String enderecoRestaurante;
  String itemPedido;
  String cliente;
  String nomeRestaurante;
  String enderecoCliente;
  dynamic idPedido;

  late String emailUsuario;
  late Logistica logistica;

  ImagemTexto(
      {Key? key,
      required this.imagePath,
      required this.enderecoRestaurante,
      required this.itemPedido,
      required this.cliente,
      required this.nomeRestaurante,
      required this.enderecoCliente,
      required this.idPedido,
      required this.emailUsuario})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    MaterialApp(
      routes: {
        '/login': (context) => TelaLogin(
              login: Login('', ''),
              emailUsuario: '',
            ),
        // outras rotas
      },
      // resto da configuração do MaterialApp
    );

    if (emailUsuario.isEmpty) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }

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
                        Text(
                          nomeRestaurante,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arimo'),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: MemoryImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          enderecoRestaurante,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'LeagueSpartan'),
                        ),
                        const Text(
                          '\nPedido:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'LeagueSpartan'),
                        ),
                        Text(
                          itemPedido,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              overflow: TextOverflow.fade,
                              fontFamily: 'LeagueSpartan'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Cliente:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'LeagueSpartan'),
                        ),
                        Text(
                          cliente,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'LeagueSpartan'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          enderecoCliente,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Arimo'),
                        ),
                        const SizedBox(height: 10),
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
                                  imagemRestaurantePedido: imagePath,
                                  idPedido: idPedido,
                                  logistica:
                                      Logistica('admin', 'fretefrete', 'token'),
                                  emailUsuario: emailUsuario.toString(),
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
                    image: MemoryImage(imagePath),
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
                    nomeRestaurante,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontFamily: 'Arimo'),
                  ),
                  Text(
                    enderecoRestaurante,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontFamily: 'Arimo'),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Pedido:',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, fontFamily: 'Arimo'),
                  ),
                  Text(
                    itemPedido,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontFamily: 'Arimo'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
