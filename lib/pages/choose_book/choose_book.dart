// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/choose_chapter/choose_chapter.dart';

class ChooseBookPage extends StatelessWidget {
  const ChooseBookPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros da Bíblia'),
      ),
      body: ListView(
        children: [
          buildTestamentoSection('Antigo Testamento', antigoTestamento, context),
          buildTestamentoSection('Novo Testamento', novoTestamento, context),
        ],
      ),
    );
  }

  Widget buildTestamentoSection(String titulo, List<Livro> livros, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 52, 124, 92),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...livros.map((livro) {
              return ListTile(
                title: Text(
                  livro.nome,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseChapterPage(livro: livro),
                    ),
                  );
                },
              );
            // ignore: unnecessary_to_list_in_spreads
            }).toList(),
          ],
        ),
      ),
    );
  }
}