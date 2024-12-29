// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:myapp/componentes/jogo_da_velha.dart';

import 'componentes/jogo_da_velha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String titulo = 'Jogo da Velha';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(titulo),
          backgroundColor: Colors.purple.shade200,
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Layout Superior
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                alignment: Alignment.center,
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Três colunas (Primeira, Segunda e Terceira)
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Primeira Coluna
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const Text(
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  // Segunda Coluna
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 166, 166, 166),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: JogoDaVelha(),
                        )
                        // Widget Calculadora usado corretamente
                        ),
                  ),

                  // Terceira Coluna
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const Text(
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Layout Inferior
            Expanded(
              flex: 2,
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                alignment: Alignment.center,
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
