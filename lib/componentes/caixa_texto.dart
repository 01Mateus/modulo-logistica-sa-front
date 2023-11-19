import 'package:flutter/material.dart';

class CaixaTexto extends StatefulWidget {
  final TextEditingController controlador;
  final String msgValidacao;
  final String texto;
  final bool senha;
  final IconData icone;


  const CaixaTexto({Key? key, required this.controlador, required this.msgValidacao, required this.texto, required this.senha, required this.icone,}) : super(key: key);

  @override
  _CaixaTextoState createState() => _CaixaTextoState();
}

class _CaixaTextoState extends State<CaixaTexto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.msgValidacao;
          }
        },
        obscureText: widget.senha,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.texto,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true, 
          fillColor: const Color.fromARGB(255, 77, 106, 109), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: Padding(
            padding: const EdgeInsets.all(9),
            child: Icon(
              widget.icone,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
  