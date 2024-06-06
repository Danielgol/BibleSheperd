// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});
  @override
  _ChooseChapterScreenState createState() => _ChooseChapterScreenState();
}

class _ChooseChapterScreenState extends State<SharePage> {

  String errorMsg = "";
  final TextEditingController _textController = TextEditingController();

  Future<bool> _checkRoomExists(String roomCode) async {
    var exists = true;
    final response = await http.get(Uri.parse('http://10.0.0.111:3000/roomExists?roomCode=$roomCode'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      exists = jsonResponse['result'];
    } else {
      throw Exception('Failed to check room code');
    }
    return exists;
  }

  void connectToServer(BuildContext context) async {
    var exists = await _checkRoomExists(_textController.text);
    if(exists){
      setState(() {
        errorMsg = "This room already exists!";
      });
    }else{
      SocketService.instance.initializeSocketConnection();
      SocketService.instance.webSocketSender('enter_room', _textController.text);
      Navigator.push(
        context,
         MaterialPageRoute(builder: (context) => ChooseBookPage(roomCode: _textController.text, userType: UserType.creator)),
      );
      SocketService.instance.initializeSocketConnection();
      SocketService.instance.webSocketSender('create_room', _textController.text);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ActualTheme.actualTheme.getPrimary(),
        iconTheme: IconThemeData(
          color: ActualTheme.actualTheme.getTextColor(), //change your color here
        ),
        title: Text(
            'Create Room',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
      ),
      backgroundColor: ActualTheme.actualTheme.getPrimary(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Create a room code:',
              style: TextStyle(fontSize: 18, color: ActualTheme.actualTheme.getTextColor()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _textController,
              style: TextStyle(fontSize: 20, color: ActualTheme.actualTheme.getTextColor()),
              decoration: InputDecoration(
                hintText: "Type Here",
                hintStyle: TextStyle(fontSize: 16, color: ActualTheme.actualTheme.getTextColor()),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ActualTheme.actualTheme.getSecondary(),
              ),
              onPressed: () => {
                //Adicione aqui a lógica para criar a sala
                connectToServer(context),
              },
              child: Text(
                'Create',
                style: TextStyle(
                  color: Color.fromARGB(255, 241, 247, 251),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 20),
            if(errorMsg != "")...{
              Text(
                errorMsg,
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 65, 65),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}