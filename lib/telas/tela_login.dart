import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _telaLoginState();
}
final txtUsername = TextEditingController();
final txtPassword = TextEditingController();
final formKey = GlobalKey<FormState>();

class _telaLoginState extends State<TelaLogin> {
  @override

  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 224, 204), 
      body: criarConteudo(),
      
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
    Navigator.of(context).pushNamed('/pedidos');
    }
  }

criarConteudo() {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
         child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          const SizedBox(
            width: 190,
            height: 200,
            child: CircleAvatar(foregroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2021/02/25/12/03/courier-6048941_1280.png'),
            ),
          ), 
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: CaixaTexto(
                    texto: 'Nome de usuário',
                    msgValidacao: 'Digite um nome de usuário',
                    controlador: txtUsername,
                    senha: false,
                    icone: Icons.person,
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
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: CaixaTexto(
                    texto: 'Senha',
                    msgValidacao: 'Digite uma senha',
                    controlador: txtPassword,
                    senha: true,
                    icone: Icons.lock,
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
                  cor: const Color.fromARGB(255, 77, 106, 109),
                  icone: Icons.account_circle,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    ),
   
  );
}

}