import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class EncryptionHelper {
  
  // static String encryptAesGcm(String base64Key, String plainText) {

  //   var cipherText = "";

  //   try {
  //     final key = encrypt.Key.fromBase64(base64Key);
  //     // final key = encrypt.Key.fromLength(32);

  //     final nonce = encrypt.IV.fromLength(12);

  //     final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));      

  //     var encryptedData = encrypter.encrypt(plainText, iv: nonce);

  //     cipherText = encryptedData.base64;

  //     debugPrint("------ [Byte length]: ${encryptedData.bytes.length}");

  //   } catch (e) {
  //     return "";
  //   }

  //   // Contains ciphertext, nonce, and MAC (tag)
  //   return cipherText;
  // }

  // static String decryptAesGcm(String base64Key, String cipherText, String nonce) {

  //   var plainText = "";
    
  //   try {
  //     final key = encrypt.Key.fromBase64(base64Key);
  //     // final key = encrypt.Key.fromLength(32);

  //     final iv = encrypt.IV.fromBase64(nonce);

  //     final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

  //     plainText = encrypter.decrypt64(cipherText, iv: iv);

  //   } catch (e) {
  //     return "";
  //   }

  //   return plainText;
  // }

  static Future<String> encryptData(String plaintext, String key, List<int> aad) async {

    List<int> plaintextBytes = utf8.encode(plaintext);
    // List<int> keyBytes = utf8.encode(key);
     List<int> keyBytes = base64Decode(key);

    debugPrint("------ encryptData: [$key]");
    debugPrint("------ encryptData [Key length]: [${keyBytes.length}] Bytes");

    final algorithm = AesGcm.with256bits();

    final secretKey = await algorithm.newSecretKeyFromBytes(keyBytes);
    // algorithm.newSecretKey();

    final nonce = algorithm.newNonce(); // Generate a new, random nonce

    final secretBox = await algorithm.encrypt(
      plaintextBytes,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad
    );

    debugPrint(secretBox.toString());

    debugPrint("secretBox.nonce: ${secretBox.nonce.length} Bytes");
    debugPrint("secretBox.cipherText: ${secretBox.cipherText.length} Bytes");        
    debugPrint("secretBox.mac: ${secretBox.mac.bytes.length} Bytes");
    

     // Contains ciphertext, nonce, and MAC (tag)
    return base64.encode(secretBox.concatenation());
  }

  static Future<List<int>> decryptData(List<int> cipherText, List<int> nonce, List<int> tag, String key, List<int> aad) async {

    // List<int> keyBytes = utf8.encode(key);
    List<int> keyBytes = base64Decode(key);

    debugPrint("------ decryptData [Key length]: [${keyBytes.length}] Bytes");

    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKeyFromBytes(keyBytes);
    final decryptedData = await algorithm.decrypt(
      SecretBox(
        cipherText,
        nonce: nonce,
        mac: Mac(tag)
      ),
      secretKey: secretKey,
      aad: aad
    );
    return decryptedData;
  }

}