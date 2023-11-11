import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';

class ImagemTexto extends StatelessWidget {
  final String imagePath;
  final String endereco;
  final String pedido;

  const ImagemTexto({Key? key, required this.imagePath, required this.endereco, required this.pedido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 178, 185, 185),
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