// ignore_for_file: avoid_print, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/caixa_texto.dart';
import 'package:modulo_logistica_sa/modelos/login.dart';

class TelaLogin extends StatefulWidget {
  final Login login; // Recebendo a instância de Login
  const TelaLogin({Key? key, required this.login}) : super(key: key);


  @override
  State<TelaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<TelaLogin> {
  late TextEditingController txtUsername = TextEditingController();
  late TextEditingController txtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();   

   @override
     void initState() {
    super.initState();
    
    txtUsername = TextEditingController(text: widget.login.loginUsuario);
    txtPassword = TextEditingController(text: widget.login.senhaUsuario);
  } 
  

   Future<Map<String, dynamic>?> buscarApiLogin(

    String loginApi,
    String senhaApi,
  ) async {
    Map<String, dynamic> request = {
      'email': loginApi,
      'senha': senhaApi,
    };

    final uriLogin = Uri.parse("https://gestao-de-cadastros-api-production.up.railway.app/auth");

    try {
      Response response = await post(uriLogin,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          // Adicione os cabeçalhos necessários aqui, como autorização, etc.
        },
      );

      

      if (response.statusCode == 200) {
        Map<String, dynamic> responseDataLogin = json.decode(response.body);
        
        return responseDataLogin;
      } else {
        // Tratar outros códigos de status, se necessário
        print('Erro na requisição: ${response.statusCode}');
        return null; // Ou lançar uma exceção com detalhes do erro
      }
    } catch (e) {
      // Tratar erros de conexão ou requisição
      print('Erro na requisição exception: $e');
      return null; // Ou lançar uma exceção com detalhes do erro
    }
  }
  

void login() async {
    if (formKey.currentState!.validate()) {
      String loginApi = txtUsername.text;
      String senhaApi = txtPassword.text;

      Map<String, dynamic>? response = await buscarApiLogin(loginApi, senhaApi);
      if (response != null) {
        // Aqui você pode usar os dados da resposta, se necessário
        // Exemplo: String token = response['token'];
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/pedidos');
      } else {
        // Tratar erro de autenticação
        // Exemplo: exibir mensagem de erro para o usuário
        txtUsername.text = "Login ou senha inválidos";
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