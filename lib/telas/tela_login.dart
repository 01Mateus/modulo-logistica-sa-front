// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> buscarApiLogin(
    String loginApi,
    String senhaApi,
  ) async {
    Map<String, dynamic> request = {
      'email': loginApi,
      'senha': senhaApi,
    };

    final uri = Uri.parse("https://gestao-de-cadastros-api-production.up.railway.app/auth");
    try {
      Response response = await post(uri,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          // Adicione os cabeçalhos necessários aqui, como autorização, etc.
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        
        print(responseData);
        return responseData;
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
        Navigator.of(context).pushNamed('/pedidos');
      } else {
        // Tratar erro de autenticação
        // Exemplo: exibir mensagem de erro para o usuário
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

  Widget criarConteudo() {
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: TextFormField(
                      controller: txtUsername,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite um nome de usuário';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nome de usuário',
                        prefixIcon: Icon(Icons.person),
                      ),
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
                    child: TextFormField(
                      controller: txtPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite uma senha';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock),
                      ),
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
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 106, 109),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Login'),
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
