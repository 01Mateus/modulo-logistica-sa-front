import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  final texto;
  final funcao;
  final Color cor;
  final IconData icone;
  
  const Botao({super.key, this.texto, this.funcao, required this.cor, required this.icone});

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: widget.cor,
          shadowColor: const Color.fromARGB(255, 148, 148, 148),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
          minimumSize: const Size(200, 50),
        ),
        onPressed: widget.funcao,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.texto),
            const SizedBox(width: 9),
            Icon(widget.icone),
          ],
        )
      ),
    );
  }
}
