import 'package:encrypt/encrypt.dart';

String encryptText(String plainText, String secretKey) {
  final key = Key.fromUtf8(secretKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}

String decryptText(String encryptedText, String secretKey) {
  final key = Key.fromUtf8(secretKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = Encrypted.fromBase64(encryptedText);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  return decrypted;
}

