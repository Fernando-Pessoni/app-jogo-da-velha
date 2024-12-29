import 'dart:math';
import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.filled(9, '');
  String _jogador = 'X';
  String _mensagem = '';
  bool _contraMaquina = false;
  final Random _randomico = Random();

  void _iniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _jogador = 'X';
      _mensagem = '';
    });
  }

  void _trocaJogador() {
    setState(() {
      _jogador = _jogador == 'X' ? 'O' : 'X';
    });
  }

  void _mostreDialogoVencedor(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(vencedor == 'Empate' ? 'Empate!' : 'Vencedor: $vencedor'),
          actions: [
            ElevatedButton(
              child: const Text('Reiniciar Jogo'),
              onPressed: () {
                Navigator.of(context).pop();
                _iniciarJogo();
              },
            ),
          ],
        );
      },
    );
  }

  bool _verificaVencedor(String jogador) {
    const posicoesVencedoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var posicoes in posicoesVencedoras) {
      if (_tabuleiro[posicoes[0]] == jogador &&
          _tabuleiro[posicoes[1]] == jogador &&
          _tabuleiro[posicoes[2]] == jogador) {
        _mostreDialogoVencedor(jogador);
        return true;
      }
    }
    if (!_tabuleiro.contains('')) {
      _mostreDialogoVencedor('Empate');
      return true;
    }
    return false;
  }

  void _jogada(int index) {
    if (_tabuleiro[index] == '' && _mensagem == '') {
      setState(() {
        _tabuleiro[index] = _jogador;
        if (!_verificaVencedor(_jogador)) {
          _trocaJogador();
          if (_contraMaquina && _jogador == 'O') {
            _jogadaComputador();
          }
        }
      });
    }
  }

  void _jogadaComputador() {
    int index;
    do {
      index = _randomico.nextInt(9);
    } while (_tabuleiro[index] != '');
    _jogada(index);
  }

  @override
  Widget build(BuildContext context) {
    double alturaTabuleiro = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: _contraMaquina,
                      onChanged: (value) {
                        setState(() {
                          _contraMaquina = value;
                          _iniciarJogo();
                        });
                      },
                    ),
                  ),
                  const Text('Modo Máquina'),
                ],
              ),
              SizedBox(
                height: alturaTabuleiro,
                width: alturaTabuleiro,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _jogada(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            _tabuleiro[index],
                            style: const TextStyle(fontSize: 40.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 0.01),
              Text(
                _mensagem,
                style: const TextStyle(fontSize: 20.0),
              ),
              ElevatedButton(
                onPressed: _iniciarJogo,
                child: const Text('Reiniciar Jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
