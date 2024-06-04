// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


final class SocketService {

  //Singleton pattern
  static final SocketService instance = SocketService();

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return "http://10.0.0.111:3000"; //Debug host url
      default:
        return "http://10.0.0.111:3000"; //Product host url
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





// class SocketServiceT with ChangeNotifier {

//   late IO.Socket socket;
//   Map? reference;

//   SocketService() {
//     socket = IO.io('http://10.0.0.111:3000', IO.OptionBuilder().setTransports(['websocket']).build());

//     socket.onConnect((_) {
//       print('Connected to server');
//     });

//     socket.onDisconnect((_) => print('Disconnected from server'));

//     // socket.on('reference', (data) {
//     //   print(data);
//     //   reference = data;
//     // });
//   }

//   bool get isConnected => socket.connected;
  
//   IO.Socket getSocket() {
//     return socket;
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   void getReferenceFromCode(code) {
//     socket.emit('get_reference', code);
//   }

// }