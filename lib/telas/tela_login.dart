import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';

class telaLogin extends StatefulWidget {
  const telaLogin({super.key});

  @override
  State<telaLogin> createState() => _telaLoginState();
}
final txtUsername = TextEditingController();
final txtPassword = TextEditingController();
final formKey = GlobalKey<FormState>();

class _telaLoginState extends State<telaLogin> {
  @override

  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 241, 214), 
      appBar: criarAppBar(),
      body: criarConteudo(),
      
    );
  }

  login() {
    if (txtUsername == 'a' && txtPassword == '123') {
      Navigator.of(context).pushNamed('/pedidos');
    }
  }

  criarConteudo() {
  return Center(
    child: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200), 
            child: CaixaTexto(
              texto: '',
              msgValidacao: 'Digite um nome de usuário',
              controlador: txtUsername,
              senha: false,
            ),
          ),
          const SizedBox(height: 20), 
          Container(
            constraints: const BoxConstraints(maxWidth: 200), 
            child: CaixaTexto(
              texto: '',
              msgValidacao: 'Digite uma senha',
              controlador: txtPassword,
              senha: true,
            ),
          ),
          const SizedBox(height: 20), 
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, 
              backgroundColor: Colors.grey,
              side: const BorderSide(color: Colors.white), 
            ),
            child: const Text('Login'),
          ),
        ],
      ),
    ),
  );
}

  criarAppBar() {

  }

  }