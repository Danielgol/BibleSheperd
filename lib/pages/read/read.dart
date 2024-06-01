// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/socket_service.dart';
import 'package:provider/provider.dart';


Future<List<Versiculo>> carregarVersiculos() async {
  final String response = await rootBundle.loadString('assets/kjv.json');
  final List<dynamic> data = jsonDecode(response);
  return data.map((json) => Versiculo.fromJson(json)).toList();
}




class ReadPage extends StatefulWidget {
  final String livro;
  final int capitulo;
  final String code;
  ReadPage({super.key, required this.livro, required this.capitulo, required this.code});
  
  @override
  _SocketListenerPageState createState() => _SocketListenerPageState();
}

class _SocketListenerPageState extends State<ReadPage> {

  late String livro = '';
  late int capitulo = 0;
  
  Future<List<Versiculo>> carregarVersiculosDoCapitulo(livro, capitulo) async {
    List<Versiculo> todosVersiculos = await carregarVersiculos();
    return todosVersiculos
        .where((versiculo) => versiculo.book == livro && versiculo.chapter == capitulo)
        .toList();
  }

  @override
  void initState() {
    // Configuração do socket
    livro = widget.livro;
    capitulo = widget.capitulo;
    final socketService = Provider.of<SocketService>(context, listen: false);
    if(widget.code != '') {
      if (socketService.reference != {}){
        livro = socketService.reference['book'];
        capitulo = socketService.reference['chapter'];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            if (widget.code != '')...{
              Text('$livro $capitulo: ${widget.code}'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // Ação ao pressionar o botão X
                  _showConfirmationDialog(context);
                },
              ),
            }else
              Text('$livro $capitulo'),
            ],
        ),
      ),
      body: FutureBuilder<List<Versiculo>>(
        future: carregarVersiculosDoCapitulo(livro, capitulo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar versículos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum versículo encontrado.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final versiculo = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${versiculo.verse} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: versiculo.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}