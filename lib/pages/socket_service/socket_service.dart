// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// https://medium.com/@ocakirsaz/real-time-chat-app-with-websocket-flutter-nestjs-65ec6429066a

final class SocketService {

  //Singleton pattern
  static final String URL = "https://bshepherd-backend.onrender.com";
  static final String PORT = "10000";
  static final SocketService instance = SocketService();

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return URL; //Debug host url
      default:
        return URL; //Product host url
    }
  }

  //Our socket object
  IO.Socket get socket => IO.io(
      _fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());

  bool get isConnected => socket.connected;

  initializeSocketConnection() {
    // if (!isConnected) { 
    // }
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success!");
      });
    } catch(e) {
      debugPrint('$e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint("Websocket disconnected"));
  }

  //Getting data from subscribed messages and calling onEvent callback
  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  //Sending data to any channel
  void webSocketSender(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }
  
}