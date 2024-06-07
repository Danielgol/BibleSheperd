// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/read/read_controller.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';


class ReadPage extends StatefulWidget {
  String livro = "";
  int capitulo = 0;
  String roomCode = "";
  UserType userType = UserType.offline;
  ReadPage({super.key, required this.livro, required this.capitulo, required this.roomCode, required this.userType});
  
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
    if (widget.userType == UserType.offline){
      livro = widget.livro;
      capitulo = widget.capitulo;
    }else{
      SocketService.instance.webSocketSender('get_reference', widget.roomCode);
      listenMessageEvent((){
        setState(() {});
      });

      SocketService.instance.webSocketReceiver('close_room', (data) {
        setState(() {
          SocketService.instance.disconnectFromSocket();
          Navigator.of(context).pop();
          Navigator.of(context).popUntil((route) => route.isFirst);
          return _showRoomClosedDialog(context);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        if(didPop){
          return;
        }
        if(widget.userType == UserType.follower){
          _showConfirmationDialog(context);
          return;
        }
        Navigator.of(context).pop();
        return;
      }),
      child: Scaffold(
        backgroundColor: ActualTheme.actualTheme.getPrimary(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ActualTheme.actualTheme.getTextColor(), //change your color here
          ),
          backgroundColor: ActualTheme.actualTheme.getPrimary(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.userType == UserType.offline)... {
                Text(
                  '$livro $capitulo',
                  style: TextStyle(
                    color: ActualTheme.actualTheme.getTextColor(),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              }else if(widget.userType == UserType.creator)...{
                Text(
                  '$livro $capitulo',
                  style: TextStyle(
                    color: ActualTheme.actualTheme.getTextColor(),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
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
                    widget.roomCode,
                    style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  icon: Icon(Icons.close, color: ActualTheme.actualTheme.getTextColor()),
                ),
              }else if(widget.userType == UserType.follower)...{
                if (livro == '' || capitulo == 0)... {
                  Text(
                    "Aguardando...",
                    style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.roomCode,
                    style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                }else...{
                  Text(
                    '$livro $capitulo',
                    style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.roomCode,
                    style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                }
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
              return Center(child: Text('Erro ao carregar versículos.', style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                    )));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum versículo encontrado.', style: TextStyle(
                      color: ActualTheme.actualTheme.getTextColor(),
                    )));
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
                                  text: '${versiculo.verse} ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ActualTheme.actualTheme.getTextColor(),
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: versiculo.text,
                                  style: TextStyle(
                                    color: ActualTheme.actualTheme.getTextColor(),
                                    fontSize: 20,
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

                  if (widget.userType != UserType.follower)...{
                    Positioned(
                      bottom: 20, // Distância do botão ao fundo da tela
                      left: 20, // Distância do botão à esquerda da tela
                      child: ElevatedButton(
                        onPressed: () {
                          goPreviousChapter(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(24),
                          backgroundColor: ActualTheme.actualTheme.getTernary()
                        ),
                        child: Icon(Icons.arrow_back, color: ActualTheme.actualTheme.getTextColor()),
                      ),
                    ),

                    Positioned(
                      bottom: 20, // Distância do botão ao fundo da tela
                      right: 20, // Distância do botão à direita da tela
                      child: ElevatedButton(
                        onPressed: () {
                          goNextChapter(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(24),
                          backgroundColor: ActualTheme.actualTheme.getTernary()
                        ),
                        child: Icon(Icons.arrow_forward, color: ActualTheme.actualTheme.getTextColor()),
                      ),   
                    ),

                  }
                ],
              );
            }
          },
        ),
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
    if(widget.userType == UserType.creator){
      SocketService.instance.webSocketSender('set_reference',
        {'roomCode': widget.roomCode, 'book': livro, 'chapter': capitulo}
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
    if(widget.userType == UserType.creator){
      SocketService.instance.webSocketSender('set_reference',
        {'roomCode': widget.roomCode, 'book': livro, 'chapter': capitulo}
      );
    }
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
                SocketService.instance.disconnectFromSocket();
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  void _showRoomClosedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ActualTheme.actualTheme.getPrimSmooth(),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'The room was closed!',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}