import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class EncryptionHelper {
  
  static String encryptAesGcm(String base64Key, String plainText) {

    var cipherText = "";

    try {
      final key = encrypt.Key.fromBase64(base64Key);
      // final key = encrypt.Key.fromLength(32);

      final nonce = encrypt.IV.fromLength(12);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));      

      var encryptedData = encrypter.encrypt(plainText, iv: nonce);

      cipherText = encryptedData.base64;

      debugPrint("------ [Byte length]: ${encryptedData.bytes.length}");

    } catch (e) {
      return "";
    }

    // Contains ciphertext, nonce, and MAC (tag)
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

  Future<SecretBox> encryptData(List<int> plaintext, SecretKey key) async {
    final algorithm = AesGcm.with256bits();
    final nonce = algorithm.newNonce(); // Generate a new, random nonce
    final secretBox = await algorithm.encrypt(
      plaintext,
      secretKey: key,
      nonce: nonce,
    );
    return secretBox; // Contains ciphertext, nonce, and MAC (tag)
  }

  Future<List<int>> decryptData(SecretBox secretBox, SecretKey key) async {
    final algorithm = AesGcm.with256bits();
    final decryptedData = await algorithm.decrypt(
      secretBox,
      secretKey: key,
    );
    return decryptedData;
  }

}