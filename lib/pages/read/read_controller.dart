
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

mixin class ReadController {

  String livro = 'oupa';
  int capitulo = 0;
  //final TextEditingController msgController = TextEditingController();

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