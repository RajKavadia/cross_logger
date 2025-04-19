import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final _key = Key.fromUtf8('12345678901234567890123456789012');
  final _iv = IV.fromLength(16);

  late final Encrypter _encrypter = Encrypter(AES(_key));

  String encrypt(String plainText) => _encrypter.encrypt(plainText, iv: _iv).base64;

  String decrypt(String encryptedText) => _encrypter.decrypt64(encryptedText, iv: _iv);
}
