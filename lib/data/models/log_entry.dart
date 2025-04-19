import '../../core/encryption/encryption_service.dart';
import '../../domain/entity/Log.dart';

class LogEntry {
  final String encryptedMessage;
  final DateTime timestamp;

  LogEntry({
    required this.encryptedMessage,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'message': encryptedMessage,
        'timestamp': timestamp.toIso8601String(),
      };

  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
        encryptedMessage: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  Log toDomain(EncryptionService? encryptionService) {
    final decrypted = encryptionService?.decrypt(encryptedMessage) ?? encryptedMessage;
    return Log(message: decrypted, timestamp: timestamp);
  }

  static LogEntry fromDomain(Log log, EncryptionService? encryptionService) {
    final encrypted = encryptionService?.encrypt(log.message) ?? log.message;
    return LogEntry(encryptedMessage: encrypted, timestamp: log.timestamp);
  }
}
