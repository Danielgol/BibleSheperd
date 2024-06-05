// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
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
      listenMessageEvent((){
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: actual_theme,
      appBar: AppBar(
        backgroundColor: actual_theme,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.code != '')... {
              if (livro == '' || capitulo == 0)... {
                Text('Aguardando...'),
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
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length+1,
                  itemBuilder: (context, index) {
                    if(index < snapshot.data!.length){
                      final versiculo = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: .0),
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
                    }else{
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2, // 20% da altura da tela
                      );
                    }
                  },
                ),

                Positioned(
                  bottom: 20, // Distância do botão ao fundo da tela
                  left: 20, // Distância do botão à esquerda da tela
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione ação desejada
                      goPreviousChapter(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 52, 69, 84)
                    )),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

                Positioned(
                  bottom: 20, // Distância do botão ao fundo da tela
                  right: 20, // Distância do botão à direita da tela
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione ação desejada
                      goNextChapter(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 52, 69, 84)
                    )),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],

            );
          }
        },
      ),
    );
  }

  void goPreviousChapter(BuildContext context) {
    if(capitulo > 1){
      capitulo -= 1;
      setState(() {});
    }else{
      int livroAtual = 0;
      for (int i = 0; i < bible.length; i++) {
        if (bible[i].nome == livro) {
          livroAtual = i;
          break;
        }
      }
      if (livroAtual-1 >= 0){
        livro = bible[livroAtual-1].nome;
        capitulo = bible[livroAtual-1].capitulos;
        setState(() {});
      }
    }

    if(widget.code != ''){
      SocketService.instance.webSocketSender('set_reference',
        {'roomCode': widget.code, 'book': livro, 'chapter': capitulo}
      );
    }
  }

  void goNextChapter(BuildContext context) {
    int livroAtual = 0;
    for (int i = 0; i < bible.length; i++) {
      if (bible[i].nome == livro) {
        livroAtual = i;
        break;
      }
    }
    if(capitulo < bible[livroAtual].capitulos){
      capitulo += 1;
      setState(() {});
    }else if (livroAtual+1 < bible.length){
      livro = bible[livroAtual+1].nome;
      capitulo = 1;
      setState(() {});
    }

    if(widget.code != ''){
      SocketService.instance.webSocketSender('set_reference',
        {'roomCode': widget.code, 'book': livro, 'chapter': capitulo}
      );
    }
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
                if (widget.code != ''){
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