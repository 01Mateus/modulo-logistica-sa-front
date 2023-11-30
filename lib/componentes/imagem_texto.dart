import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/telas/tela_entregas.dart';

class ImagemTexto extends StatelessWidget {
  final String imagePath;
  final String endereco;
  final String itemPedido;
  final String qntItemPedido;
  final String cliente;
  final bool mostrarBotaoPedido;
  final bool mostrarBotaoConcluir;
  final bool mostrarBotaoFechar;

 

  const ImagemTexto({Key? key, required this.imagePath, required this.endereco, required this.itemPedido, required this.cliente, this.mostrarBotaoPedido = true, this.mostrarBotaoConcluir = true, this.mostrarBotaoFechar = true, required this.qntItemPedido,})
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
                      backgroundImage: NetworkImage(imagePath),
                    ),
                   const SizedBox(height: 10),
                    Text(
                      endereco,
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
                    if (mostrarBotaoPedido)
                      Botao(texto: 'Aceitar Pedido',
                            funcao: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => TelaEntregas(
                                      imagePath: imagePath,
                                      endereco: endereco,
                                      qntItemPedido: qntItemPedido,
                                      itemPedido: itemPedido,
                                      cliente: cliente,
                                    )
                                  )
                                );
                            },
                            cor: Colors.blue,
                            icone: Icons.add,
                            ),
                    if (mostrarBotaoConcluir) 
                      Botao(texto: 'Finalizar Entrega',
                            funcao: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop('/pedidos');
                            },
                            cor: Colors.blue,
                            icone: Icons.check,
                            ),
                    if (mostrarBotaoFechar)
                      Botao(texto: '',
                            funcao: () {
                              Navigator.of(context).pop();
                            },
                            cor: Colors.blue,
                            icone: Icons.close,
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
          borderRadius: BorderRadius.circular(8),
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
                    endereco,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}