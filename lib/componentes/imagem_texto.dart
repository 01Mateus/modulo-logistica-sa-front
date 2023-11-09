import 'package:flutter/material.dart';

class imagemTexto extends StatelessWidget {
  final String imagePath;
  final String text;
  
  const imagemTexto({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
           decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 209, 222, 222), 
        ),
        padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            imagePath,
            width: 230,
            height: 200,
          ),
          const SizedBox(height: 7),
          Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

}