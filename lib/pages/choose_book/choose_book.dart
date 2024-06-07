// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/choose_chapter/choose_chapter.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class ChooseBookPage extends StatelessWidget {

  final String roomCode;
  final UserType userType;
  const ChooseBookPage({super.key, required this.roomCode, required this.userType});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ActualTheme.actualTheme.getPrimary(),
      appBar: AppBar(
        backgroundColor: ActualTheme.actualTheme.getPrimary(),
        iconTheme: IconThemeData(
          color: ActualTheme.actualTheme.getTextColor(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bible Shepherd',
              style: TextStyle(
                color: ActualTheme.actualTheme.getTextColor(),
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
            if (userType == UserType.creator)
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: ActualTheme.actualTheme.getTextColor()),
                  backgroundColor: ActualTheme.actualTheme.getPrimSmooth(),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                onPressed: () => {
                  // botão X
                  _showConfirmationDialog(context)
                },
                label: Text(
                  roomCode,
                  style: TextStyle(
                    color: ActualTheme.actualTheme.getTextColor(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(Icons.close, color: ActualTheme.actualTheme.getTextColor()),
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
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        if(didPop){
          return;
        }
        if(userType == UserType.creator){
          _showConfirmationDialog(context);
          return;
        }
        Navigator.of(context).pop();
        return;
      }),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: ActualTheme.actualTheme.getTernary(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ActualTheme.actualTheme.getSecondary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  titulo,
                  style: TextStyle(
                    color: Color.fromARGB(255, 241, 247, 251),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...livros.map((livro) {
                return ListTile(
                  title: Text(
                    livro.nome,
                    style: TextStyle(fontSize: 16, color: ActualTheme.actualTheme.getTextColor()),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ActualTheme.actualTheme.getTextColor()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseChapterPage(livro: livro, roomCode: roomCode, userType: userType),
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
      )
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ActualTheme.actualTheme.getPrimSmooth(),
          title: Text(
            'You are leaving!',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
          content: Text(
            'Would you like to leave the room?',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                if(userType == UserType.creator){
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