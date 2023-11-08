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
      backgroundColor: Color.fromARGB(255, 236, 241, 214), 
      appBar: criarAppBar(),
      body: criarConteudo(),
      
    );
  }

  login() {
    if (txtUsername == 'a' && txtPassword == '123') {
      Navigator.of(context).pushNamed('/pedidos');
      print('Login efetuado com sucesso');
    }else {
      Navigator.of(context).pushNamed('/erro');
    }
  }

    criarConteudo() {
    return Form(
        child: Column(
          children: [
            CaixaTexto(texto: '', msgValidacao: 'Digite um nome de usuário', controlador: txtUsername, senha: false,),
            CaixaTexto(texto: '', msgValidacao: 'Digite uma senha', controlador: txtPassword, senha: true,),
            Botao(texto: 'Login', funcao: login,)
            ],
        ),
    );
  }

  criarAppBar() {

  }

  }
