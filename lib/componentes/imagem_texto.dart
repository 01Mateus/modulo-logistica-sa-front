import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';

class ImagemTexto extends StatelessWidget {
  final String imagePath;
  final String endereco;
  final String pedido;
  final String cliente;
  final String frete;
  final bool mostrarFrete;

 

  const ImagemTexto({Key? key, required this.imagePath, required this.endereco, required this.pedido, required this.cliente, required this.frete, this.mostrarFrete = true})
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
                      pedido,
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
                    if (mostrarFrete)
                      const Text(
                      'Frete:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    if (mostrarFrete)
                     Text(
                      frete,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 9),
                    Botao(
                      texto: 'Fechar',
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
                    pedido,
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