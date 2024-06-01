// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/chapter/chapter.dart';
import 'package:flutter_application/pages/models/models.dart';

class ChooseChapterPage extends StatelessWidget {
  final Livro livro;

  ChooseChapterPage({required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livro.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // Máximo de 5 botões por linha
            childAspectRatio: 1, // Torna os botões quadrados
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: livro.capitulos,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bordas levemente arredondadas
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterPage(livro: livro.nome, capitulo: index+1),
                  ),
                );
              },
              child: Text('${index + 1}'),
            );
          },
        ),
      ),
    );
  }
}