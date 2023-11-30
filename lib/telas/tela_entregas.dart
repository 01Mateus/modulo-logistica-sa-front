import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class TelaEntregas extends StatefulWidget {
  const TelaEntregas({super.key});

  @override
  State<TelaEntregas> createState() => _TelaEntregasState();
}

class _TelaEntregasState extends State<TelaEntregas> {
  @override
  Widget build(BuildContext context) {
    criarConteudo() {
      return const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2019/02/21/19/00/restaurant-4011989_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                qntItemPedido: '3',
                itemPedido: 'X-Salada\n Balde de frango\n X-Tudo',
                cliente: '', 
                mostrarBotaoPedido: false,
                mostrarBotaoConcluir: true,
                mostrarBotaoFechar: false,
              ),
            ],
          ),
          SizedBox(height: 10), 
          ],
        ),
      ), 
      );
    }
    
    return Scaffold(
      body: criarConteudo(),
      backgroundColor: const Color.fromARGB(255, 236, 241, 214),
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 77, 106, 109),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
        actions: const [
          Icon(Icons.account_circle, size: 30),
        ],
      ),
    );
  }
  
}