// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {

  late IO.Socket socket;
  var reference = {};

  SocketService() {
    socket = IO.io('http://10.0.0.113:3000', IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.onDisconnect((_) => print('Disconnected from server'));

    socket.on('reference', (data) {
      reference = data;
    });
  }

  bool get isConnected => socket.connected;
  
  IO.Socket getSocket() {
    return socket;
  }

  void dispose() {
    socket.dispose();
  }
}