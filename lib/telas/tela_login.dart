// ignore_for_file: avoid_print, camel_case_types

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';
import 'package:modulo_logistica_sa/modelos/login.dart';
import 'package:modulo_logistica_sa/modelos/urlapi.dart';

class TelaLogin extends StatefulWidget {
  final Login login;
 // Recebendo a instância de Login
  final String emailUsuario;
  const TelaLogin({Key? key, required this.login, required this.emailUsuario}) : super(key: key);


  @override
  State<TelaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<TelaLogin> {
  late TextEditingController txtUsername = TextEditingController();
  late TextEditingController txtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>(); 
  String mensagemErro = '';
  bool exibirMensagemErro = false;  

   @override
     void initState() {
    super.initState();
    _abrirTelaLoginAposAtraso();
    txtUsername = TextEditingController(text: widget.login.loginUsuario);
    txtPassword = TextEditingController(text: widget.login.senhaUsuario);
  } 
  
  
   Future<void> _abrirTelaLoginAposAtraso() async {
   
    await Future.delayed(const Duration(seconds: 5));
  }

   Future<Map<String, dynamic>?> buscarApiLogin(
    
  ) async {
    Map<String, dynamic> request = {
      'email': widget.login.loginUsuario,
      'senha': widget.login.senhaUsuario,
    };

    final uriLogin = Uri.parse(Urlapi().urlLoginCadastros);

    try {
      Response response = await post(uriLogin,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
   
        },
      );

      

      if (response.statusCode == 200) {
        Map<String, dynamic> responseDataLogin = json.decode(response.body);
        
        return responseDataLogin;
      } else {
      
        print('Erro na requisição: ${response.statusCode}');
        return null; 
      }
    } catch (e) {
   
      print('Erro na requisição exception: $e');
      return null; 
    }
  }
  

void login() async {
    if (formKey.currentState!.validate()) {
      widget.login.loginUsuario = txtUsername.text;
      widget.login.senhaUsuario = txtPassword.text;

      late String emailUsuario = txtUsername.text;

      Map<String, dynamic>? response = await buscarApiLogin();
      if (response != null) {
  
     
        print(emailUsuario);
     
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/pedidos', arguments: emailUsuario);
        
      } else {
        setState(() {
          mensagemErro = 'Login ou senha inválidos';
          exibirMensagemErro = true;
        });

        Timer(const Duration(seconds: 3), () { 
          setState(() {
            exibirMensagemErro = false;
          });
        });
   
        txtUsername.text = "";
        txtPassword.text = "";
      }
    }
  }
  
  @override

  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 224, 204), 
      body: criarConteudo(),
      
    );
  }

criarConteudo() {

  return Center(
  child: SingleChildScrollView(
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
          const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                if (exibirMensagemErro)
                  Text(
                    mensagemErro,
                    style: const TextStyle(color: Colors.red, fontSize: 20),),
          const SizedBox(height: 20),
                Botao(
                  texto: 'Login',
                  funcao: login,
                  cor: const Color.fromARGB(255, 77, 106, 109),
                  icone: Icons.account_circle,
                ),
              ],
             ),
          ),
        ),
      ),
  ); 
}

}