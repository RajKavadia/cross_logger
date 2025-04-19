import 'package:web_socket_client/web_socket_client.dart';

class WebSocketClient {
  final WebSocket _socket;

  WebSocketClient(String url) : _socket = WebSocket(Uri.parse(url)) {
    _socket.connection.listen((state) {
      print('WebSocket state: $state');
    });
  }

  void send(String message) => _socket.send(message);

  void dispose() => _socket.close();
}
