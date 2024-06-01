
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application/pages/models/models.dart';


Future<List<Versiculo>> carregarVersiculos() async {
  final String response = await rootBundle.loadString('assets/kjv.json');
  final List<dynamic> data = jsonDecode(response);
  return data.map((json) => Versiculo.fromJson(json)).toList();
}

class ChapterPage extends StatelessWidget {
  final String livro;
  final int capitulo;

  ChapterPage({super.key, required this.livro, required this.capitulo});

  Future<List<Versiculo>> carregarVersiculosDoCapitulo() async {
    List<Versiculo> todosVersiculos = await carregarVersiculos();
    return todosVersiculos
        .where((versiculo) => versiculo.book == livro && versiculo.chapter == capitulo)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$livro $capitulo'),
      ),
      body: FutureBuilder<List<Versiculo>>(
        future: carregarVersiculosDoCapitulo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar versículos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum versículo encontrado.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final versiculo = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${versiculo.verse} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: versiculo.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}