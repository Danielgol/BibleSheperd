// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/read/read_controller.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';


class ReadPage extends StatefulWidget {
  String livro = "";
  int capitulo = 0;
  String code = "";
  ReadPage({super.key, required this.livro, required this.capitulo, required this.code});
  
  @override
  _ReadViewState createState() => _ReadViewState();
}




class _ReadViewState extends State<ReadPage> with ReadController {

  Future<List<Versiculo>> carregarVersiculos() async {
    final String response = await rootBundle.loadString('assets/kjv.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Versiculo.fromJson(json)).toList();
  }
  
  Future<List<Versiculo>> carregarVersiculosDoCapitulo(livro, capitulo) async {
    List<Versiculo> todosVersiculos = await carregarVersiculos();
    return todosVersiculos
        .where((versiculo) => versiculo.book == livro && versiculo.chapter == capitulo)
        .toList();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    if (widget.code == ''){
      livro = widget.livro;
      capitulo = widget.capitulo;
    }else{
      SocketService.instance.webSocketSender('get_reference', widget.code);
      // listen update channel
      listenMessageEvent((){
        //Future.delayed(Duration.zero, () async {
        setState(() {});
        //});
      });
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

            if (widget.code != '')... {
              if (livro == '' || capitulo == 0)... {
                Text('Aguardando Capítulo...'),
              }else
                Text('$livro $capitulo'),

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
                label: Text(widget.code),
                icon: Icon(Icons.close),
              ),
            } else... {
              Text('$livro $capitulo'),
            }
              
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
                          text: '${versiculo.verse}',
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