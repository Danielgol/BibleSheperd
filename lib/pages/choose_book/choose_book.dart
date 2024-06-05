// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/choose_chapter/choose_chapter.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class ChooseBookPage extends StatelessWidget {

  final String code;
  const ChooseBookPage({super.key, required this.code});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: actual_theme,
      appBar: AppBar(
        backgroundColor: actual_theme,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bible Shepherd'),
            if (code != '')
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.blue),
                  backgroundColor: Colors.white,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                onPressed: () => {
                  // botão X
                  _showConfirmationDialog(context)
                },
                label: Text(code),
                icon: Icon(Icons.close),
              ),
            ],
        ),
      ),
      body: ListView(
        children: [
          buildTestamentoSection('Old Testament', antigoTestamento, context),
          buildTestamentoSection('New Testament', novoTestamento, context),
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
                color: Color.fromARGB(255, 52, 69, 84),
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
                      builder: (context) => ChooseChapterPage(livro: livro, code: code),
                    ),
                  );
                },
              );
            }).toList(),
          ],
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
                if(code != ''){
                  SocketService.instance.disconnectFromSocket();
                }
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
  
}