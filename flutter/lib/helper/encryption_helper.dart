import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  
  static String encryptAesGcm(String base64Key, String plainText) {

    var cipherText = "";

    try {
      final key = encrypt.Key.fromBase64(base64Key);
      // final key = encrypt.Key.fromLength(32);

      final nonce = encrypt.IV.fromLength(12);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

      cipherText = encrypter.encrypt(plainText, iv: nonce).base64;

    } catch (e) {
      return "";
    }

    return cipherText;
  }

  static String decryptAesGcm(String base64Key, String cipherText, String nonce) {

    var plainText = "";
    
    try {
      final key = encrypt.Key.fromBase64(base64Key);
      // final key = encrypt.Key.fromLength(32);

      final iv = encrypt.IV.fromBase64(nonce);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

      plainText = encrypter.decrypt64(cipherText, iv: iv);

    } catch (e) {
      return "";
    }

    return plainText;
  }

}