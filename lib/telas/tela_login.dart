import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';

class telaLogin extends StatefulWidget {
  const telaLogin({super.key});

  @override
  State<telaLogin> createState() => _telaLoginState();
}
final _txtUsername = TextEditingController();
final _txtPassword = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _telaLoginState extends State<telaLogin> {
  @override

  Widget build(BuildContext context) {
    

  login() {
    Navigator.pushNamed(context, '/pedidos');
  }

    informarLogin() {
    return Row(
      children: [
        Expanded(child: CaixaTexto(texto: "Username", controlador: _txtUsername, msgValidacao: "Digite um nome de usuário", senha: false,)),
        Expanded(child: CaixaTexto(texto: "Password", controlador: _txtPassword, msgValidacao: "Digite uma senha", senha: true,)),
      ],
    );
  }

    criarConteudo() {
    return Form(
      key: _formKey,
        child: Column(
          children: [
            informarLogin(),
            Botao(texto: 'Login', funcao: login,)
            ],
        ),
    );
  }



  criarAppBar() {

  }

    return Scaffold(
      appBar: criarAppBar(),
      body: criarConteudo(),
    );
  }
}