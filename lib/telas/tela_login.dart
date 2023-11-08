import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';

// ignore: camel_case_types
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
      body: criarConteudo(),
      
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
    Navigator.of(context).pushNamed('/pedidos');
    }
  }

criarConteudo() {
  return Center(
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 40,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: CaixaTexto(
                    texto: 'Nome de usuário',
                    msgValidacao: 'Digite um nome de usuário',
                    controlador: txtUsername,
                    senha: false,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  size: 40,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: CaixaTexto(
                    texto: 'Senha',
                    msgValidacao: 'Digite uma senha',
                    controlador: txtPassword,
                    senha: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Botao(
                  texto: 'Login',
                  funcao: login,
                ),
                const Icon(
                  Icons.account_circle, 
                  size: 35,
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

