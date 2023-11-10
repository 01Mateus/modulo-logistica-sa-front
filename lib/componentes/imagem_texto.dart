import 'package:flutter/material.dart';

class ImagemTexto extends StatelessWidget {
  final String imagePath;
  final String text1;
  final String text2;
  
  const ImagemTexto({super.key, required this.imagePath, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 209, 222, 222), 
        ),
        width: 550,
        height: 200,
      child: Row(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(imagePath),
          ), 
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18),
              ),
              const Text(
                'Pedido',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),),
              Text(
                text2,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18),
              ),
           
            ],
          )
        ],
      ),
    );
  }

}