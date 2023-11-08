import 'package:flutter/material.dart';

class telaErro extends StatefulWidget {
  const telaErro({super.key});

  @override
  State<telaErro> createState() => _telaErroState();
}

class _telaErroState extends State<telaErro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(title: const Text('Página de erro')),
      body: const Center(
        child: Text(
          'Erro ao efetuar login',
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
          ),
        ), 
      ),
    );
  }
}

