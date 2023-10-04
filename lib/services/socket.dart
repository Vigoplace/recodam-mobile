import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart';
import '/utils/utils.dart';

class SocketServices {
  static final SocketServices instance = SocketServices._init();
  static Socket? _socket;
  SocketServices._init();

  Socket get socket {
    if (_socket != null) return _socket!;
    _socket = io(AppConstant.baseUrl,
        OptionBuilder().setTransports(['websocket']).build());
    _socket!.io.options!['extraHeader'] = {
      HttpHeaders.authorizationHeader: LocalStorage.instance.getToken()
    };
    return _socket!;
  }

  void connectAndListen(WidgetRef ref) async {
    int userId = LocalStorage.instance.getId();

    socket.auth = {'userId': userId};
    socket.onConnect((data) {
      debugPrint(socket.id);
    });
    socket.onError((data) => debugPrint('Error => $data'));
    socket.onDisconnect((data) => debugPrint('Disconnected'));
  }
}
