// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/read/read.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class ChooseChapterPage extends StatelessWidget {
  final Livro livro;
  final String code;

  ChooseChapterPage({super.key, required this.livro, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: actual_theme,
      appBar: AppBar(
        backgroundColor: actual_theme,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            if (code != '')...{
              Text(livro.nome),
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
            }else...{
              Text(livro.nome),
            }

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
                if(code != '') {
                  SocketService.instance.webSocketSender('set_reference',
                    {'roomCode': code, 'book': livro.nome, 'chapter': index+1}
                  );
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadPage(livro: livro.nome, capitulo: index+1, code: code),
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
                if (code != ''){
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