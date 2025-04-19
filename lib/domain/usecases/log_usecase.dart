
import 'package:flutter/foundation.dart';

import '../../core/encryption/encryption_service.dart';
import '../../data/datasource/http_source.dart';
import '../../data/datasource/local_databse.dart';
import '../../data/datasource/web_socket_client.dart';
import '../../data/models/log_entry.dart';

class LogUseCase {
  final EncryptionService _encryptionService;
  final LocalDatabase _database;
  final WebSocketClient _webSocketClient;

  bool encryptionEnabled;

  var httpUrl = "";

  LogUseCase(this._encryptionService, this._database, this._webSocketClient, this.encryptionEnabled, this.httpUrl);

  Future<void> execute(String message) async {
    if (encryptionEnabled) {
      message = _encryptionService.encrypt(message);
    }
    final entry = LogEntry(encryptedMessage: message, timestamp: DateTime.now());
    await _database.insertLog(entry);
    _webSocketClient.send(message);
  }


  Future<void> sendLogs(Uint8List logs) async {
    var logs = await _database.getAllLogs();
    HTTPHandler().sendBlobToServer(Uint8List.fromList(logs.toString().codeUnits),"file",httpUrl);
  }
}
