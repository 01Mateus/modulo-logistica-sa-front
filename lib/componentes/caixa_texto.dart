import 'package:flutter/material.dart';

class CaixaTexto extends StatefulWidget {
  final controlador;
  final msgValidacao;
  final texto;
  final senha;

  const CaixaTexto({super.key, this.controlador, this.msgValidacao, this.texto, this.senha});

  @override
  State<CaixaTexto> createState() => _CaixaTextoState();
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          )
        )
      )
    );
  }
}