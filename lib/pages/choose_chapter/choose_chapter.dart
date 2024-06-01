// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/chapter/chapter.dart';
import 'package:flutter_application/pages/models/models.dart';

class ChooseChapterPage extends StatelessWidget {
  final Livro livro;
  final String connection;

  ChooseChapterPage({super.key, required this.livro, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(livro.nome),
            if (connection != '')
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // Ação ao pressionar o botão X
                 _showConfirmationDialog(context);
                },
              ),
            ],
        ),
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
                    builder: (context) => ChapterPage(livro: livro.nome, capitulo: index+1, connection: connection),
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You are leaving!'),
          content: Text('Would you like to leave the room?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}