// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SharePage extends StatefulWidget {
  SharePage({super.key});
  @override
  _ChooseChapterScreenState createState() => _ChooseChapterScreenState();
}

class _ChooseChapterScreenState extends State<SharePage> {
  late IO.Socket socket;

  void connectToServer() {
    SocketService.instance.initializeSocketConnection();
    SocketService.instance.webSocketSender('create_room', 'sala');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: actual_theme,
        title: Text('Create Room'),
      ),
      backgroundColor: actual_theme,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Create a room code:',
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
                //Adicione aqui a lógica para criar a sala
                connectToServer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseBookPage(code: 'sala')),
                );
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}