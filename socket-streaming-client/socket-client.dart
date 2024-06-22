import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket _socket;

  String url = "http://localhost:3000/";

  SocketClient() {
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    _socket.onConnect((_) {
      print('Connection established');
    });

    _socket.onDisconnect((_) {
      print('Connection disconnected');
    });

    _socket.on('event', (data) {
      print('Received data: $data');
    });
  }

  void emit(String event, [dynamic data]) {
    _socket.emit(event, data);
  }

  void dispose() {
    _socket.disconnect();
    _socket.dispose();
  }
}
