// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/read/read.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  void connectToServer() {
    SocketService.instance.initializeSocketConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: actual_theme,
      appBar: AppBar(
        backgroundColor: actual_theme,
        title: Text('Follow Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter the room code:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type here',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para o botão "Criar"
                // Adicione aqui a lógica para criar a sala
                connectToServer();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadPage(livro: '', capitulo: 0, code: 'sala'),
                  ),
                );
              },
              child: Text('Follow'),
            ),
          ],
        ),
      ),
    );
  }
}