import 'core/encryption/encryption_service.dart';

void main() {
  var decrypted = EncryptionService().decrypt("gU7EoYShcGOWRiLKXCwqGA==");
  print(decrypted);
}
