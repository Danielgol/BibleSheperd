
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application/pages/socket_service/socket_service.dart';

mixin class ReadController {

  String livro = '';
  int capitulo = 0;
  bool following = false;
  //final TextEditingController msgController = TextEditingController();

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

  listenMessageEvent(VoidCallback setState) {
    SocketService.instance.webSocketReceiver('reference', (data) {
      //log('aaaaaaaaaaaaaaaaaaaaaa_'+data['book']+'_${data['chapter']}' );
      livro = data['book'];
      capitulo =  data['chapter'];
      setState();
    });
  }

  sendMessage(String channel, String content, VoidCallback setState) {
    // final MessageModel data =
    //     MessageModel(sender: sender, msg: msgController.text);
    // SocketService.instance.webSocketSender(channel, data.toJson());
        
    SocketService.instance.webSocketSender(channel, content);

    //Reset input
    //msgController.text = "";
    //setState();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }

}