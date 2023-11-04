import 'package:flutter/material.dart';

class CaixaTexto extends StatefulWidget {
  final TextEditingController controlador;
  final String msgValidacao;
  final String texto;
  final bool senha;

  const CaixaTexto({Key? key, required this.controlador, required this.msgValidacao, required this.texto, required this.senha}) : super(key: key);

  @override
  _CaixaTextoState createState() => _CaixaTextoState();
}

class _CaixaTextoState extends State<CaixaTexto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.msgValidacao;
          }
        },
        obscureText: widget.senha,

        decoration: InputDecoration(
          labelText: widget.texto,
          filled: true, // Define a cor de fundo
          fillColor: Color.fromARGB(255, 163, 160, 160), // Define a cor de fundo vermelha
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
      )
    );
  }
}