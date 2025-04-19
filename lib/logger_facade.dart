import '../../core/encryption/encryption_service.dart';
import '../../domain/usecases/log_usecase.dart';
import 'data/datasource/local_databse.dart';
import 'data/datasource/web_socket_client.dart';

class LoggerFacade {
  final LogUseCase _logUseCase;

  LoggerFacade._(this._logUseCase);

  static Future<LoggerFacade> initialize(String wsUrl, bool EncryptionEnabled) async {
    final encryptionService = EncryptionService();
    final db = LocalDatabase();
    await db.init();
    final webSocketClient = WebSocketClient(wsUrl);
    final logUseCase = LogUseCase(encryptionService, db, webSocketClient, EncryptionEnabled,"");
    return LoggerFacade._(logUseCase);
  }

  Future<void> log(String message) => _logUseCase.execute(message);
}
