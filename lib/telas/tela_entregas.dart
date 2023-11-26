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
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
                mostrarFrete: true, 
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2016/11/18/22/21/restaurant-1837150_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
                mostrarFrete: true, 
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2015/02/24/11/54/vienna-647328_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
                mostrarFrete: true, 
              ),
            ],
          ),
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
          'HISTÓRICO DE ENTREGAS',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 77, 106, 109),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
        actions: const [
          Icon(Icons.account_circle, size: 30),
        ],
      ),
    );
  }
  
}