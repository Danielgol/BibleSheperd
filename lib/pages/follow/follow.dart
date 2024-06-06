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
      backgroundColor: ActualTheme.actualTheme.getPrimary(),
      appBar: AppBar(
        backgroundColor: ActualTheme.actualTheme.getPrimary(),
        iconTheme: IconThemeData(
          color: ActualTheme.actualTheme.getTextColor(), //change your color here
        ),
        title: Text(
            'Follow Room',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter the room code:',
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
              onPressed: () {
                // Follow
                connectToServer(context);
              },
              child: Text(
                'Follow',
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