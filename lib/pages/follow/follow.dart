// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/read/read.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});
  @override
  _FollowPageScreenState createState() => _FollowPageScreenState();
}

class _FollowPageScreenState extends State<FollowPage> {

  String errorMsg = "";
  final TextEditingController _textController = TextEditingController();

  Future<bool> _checkRoomExists(String roomCode) async {
    var exists = false;
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
    var sucess = await _checkRoomExists(_textController.text);
    if(sucess){
      SocketService.instance.initializeSocketConnection();
      SocketService.instance.webSocketSender('enter_room', _textController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReadPage(
            livro: '',
            capitulo: 0,
            roomCode: _textController.text,
            userType: UserType.follower
          ),
        ),
      );
    }else{ 
      setState(() {
        errorMsg = "This room doesn't exists!";
      });
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
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type here',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Follow
                connectToServer(context);
              },
              child: Text('Follow'),
            ),
            SizedBox(height: 20),
            if(errorMsg != "")...{
              Text(
                errorMsg,
                style: TextStyle(
                  color: Color.fromARGB(255, 173, 35, 35),
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