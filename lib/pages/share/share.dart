// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class SharePage extends StatefulWidget {
  SharePage({super.key});
  @override
  _ChooseChapterScreenState createState() => _ChooseChapterScreenState();
}

class _ChooseChapterScreenState extends State<SharePage> {
  late IO.Socket socket;

  void connectToServer() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.getSocket().emit('create_room', 'sala');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Room'),
      ),
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