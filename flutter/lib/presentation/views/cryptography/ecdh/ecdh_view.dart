import 'dart:convert';
import 'dart:typed_data';

import 'package:elliptic/ecdh.dart';
import 'package:elliptic/elliptic.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EcdhView extends ConsumerStatefulWidget {
  const EcdhView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EcdhView();
}

class _EcdhView extends ConsumerState<EcdhView> {

  bool isLoading = false;
  final plainText = "Hello world";
  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      var clientPrivateKey = _genKeyPair();
      var clientPublicKey = clientPrivateKey.publicKey;

      ref.read(ecdhProvider.notifier).updateData(
        privateKey: clientPrivateKey,
        publicKey: clientPublicKey
      );

      await Future.delayed(const Duration(seconds: 1), () {
        context.hideLoaderOverlay();
      });

      // Test ecdh
      // var clientPrivateKey = _genKeyPair();
      // var clientPublicKey = clientPrivateKey.publicKey;

      // var result = await ref.read(ecdhProvider.notifier).TestEcdh(clientPrivateKey.toHex(), clientPublicKey.toHex());
      // result.when(
      //   completeWithValue: (value) {
      //     // var ec = getP256();

      //     var serverPrivateKeyHex = value.data.serverPrivateKey ?? "";
      //     var serverPublicKeyHex = value.data.serverPublicKey ?? "";

      //     var serverPublicKey = _genPublicKey(serverPublicKeyHex);

      //     var cSharedSecretKey = computeSecret(clientPrivateKey, serverPublicKey);

      //     print("cSharedSecretKey: ${base64Encode(cSharedSecretKey)}");
          
      //   }, 
      //   completeWithError: (error) {
          
      //   }
      // );
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(ecdhProvider);

    return BlankPageWidget(     
      showBackBtn: false, 
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [          
              Text(
                "Elliptic Curve Diffie-Hellman (ECDH)",
                style: TextStyle(
                  fontSize: 24.spMin
                ),
              ),
              SizedBox(height: 16.h),
              _text("Client private key", state.privateKey?.toHex() ?? ""),
              SizedBox(height: 8.h),
              _text("Client public key (can share to other party)", state.publicKey?.toHex() ?? ""),
              SizedBox(height: 8.h),
              _text("Server public key (receive from other party)", state.otherPartyPublicKey?.toHex() ?? ""),
              SizedBox(height: 8.h),
              _text("Shared secret key", state.sharedSecretKey != null ? base64Encode(state.sharedSecretKey!) : ""),
              SizedBox(height: 8.h),
              _text("Key ID", state.keyId ?? ""),
              SizedBox(height: 8.h),
              _text("Plain text", plainText),
              SizedBox(height: 8.h),
              _text("Cipher text (encrypted data)", state.cipherText ?? ""),
              SizedBox(height: 8.h),
              _text("Decrypted data", ""),              
              SizedBox(height: 32.h),
              _button("Generate key pair", () {
                var privateKey = _genKeyPair();
                var publicKey = privateKey.publicKey;

                print("privateKey length: [${privateKey.bytes.length}]");
                print("publicKey length: [${privateKey.bytes.length}]");

                ref.read(ecdhProvider.notifier).updateData(
                  privateKey: privateKey,
                  publicKey: publicKey
                );

              }),
              SizedBox(height: 24.h),
              _button("Exchange public key", () async {              
                await _exchangeKey();
              }),
              SizedBox(height: 24.h),
              _button("AES encryption and send to server", () async {
                
                var sharedSecretKey = ref.read(ecdhProvider).sharedSecretKey;

                if(sharedSecretKey == null) {
                  return;
                }

                context.showLoaderOverlay();

                var cipherText = _encryptAesGcm(base64Encode(sharedSecretKey), plainText);

                ref.read(ecdhProvider.notifier).updateData(
                  cipherText: cipherText
                );

                var keyId = ref.read(ecdhProvider).keyId ?? "";

                var result = await ref.read(ecdhProvider.notifier).TestEcdh(keyId, "");
                result.when(
                  completeWithValue: (value) {
                    
                  }, 
                  completeWithError: (error) {
                    
                  }
                );

                Future.delayed(const Duration(seconds: 1), () {
                  context.hideLoaderOverlay();
                });

              }),                      
            ],
          ),
        ),
      ),
      // body: GestureDetector(
      //   onTap: () async {

      //     print("ECDH");
      //     var ec = getP256(); // elliptic curves, NIST P-256 (FIPS 186-3, section D.2.3), also known as secp256r1 or prime256v1          

      //     // fix private key for test
      //     var privateClient = PrivateKey.fromHex(ec, "fbf6a555bd15fa7beca34e3ba26679a26de3e4dbcfcd8c6c22f40d85dd2bec01");
      //     var publicClient = privateClient.publicKey;

      //     // Print client public key (send to backend)
      //     print(publicClient.curve.bitSize);
      //     print("publicKeyClient (share to server): ${publicClient.toHex()}");

      //     // var val = hexToUint8List(publicClient.toHex());
      //     // print(val);
      //     print("========================================================================");

      //     // Get server public key
      //     var publicServer = PublicKey.fromHex(ec, "04778aae16b613d212ddfc9d62cb5784d5c665746faea92d65b5699cd21b14fc75d4fd2e961d50e746334b1d5640700508fdda2a7658e266f4ec7ea53ea69d205a");

      //     // Compute shared key
      //     var secretClient = computeSecret(privateClient, publicServer);
      //     // var secretServer = computeSecret(privateServer, publicClient);

      //     print(secretClient.length);

      //     // Convert base64 format
      //     // var secretClientBase64 = base64Encode(secretClient);
        
      //     print("secretClient: $secretClient");

      //     print("========================================================================");
        
      //   },
      //   child: Text("Click"),
      // ),
    );
  }

  Widget _text(String title, String text) {
    
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              fontWeight: FontWeight.w700
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 4.r),
            color: Colors.grey.withOpacity(0.5),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              style: const TextStyle().copyWith(fontSize: 16.spMin),
            ),
          )
        ],
      ),
    );
  }

  Widget _button(String text, void Function()? onTap) {
    return GestureDetector(
      onTap: () async {

        if(isLoading) {
          return;
        }

        isLoading = true;

        if(onTap != null) {
          onTap.call();
        }

        await Future.delayed(const Duration(milliseconds: 500));

        isLoading = false;
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          )
        ),
      ),
    );
  }

  PrivateKey _genKeyPair() {
    var ec = getP256();
    return ec.generatePrivateKey();
  }

  PrivateKey _genPrivateKey(String hex) {
    return PrivateKey.fromHex(getP256(), hex);
  }

  PublicKey _genPublicKey(String hex) {
    return PublicKey.fromHex(getP256(), hex);
  }

  Future<String> _exchangeKey() async {
    
    var privateKey = ref.read(ecdhProvider).privateKey;
    var publicKey = ref.read(ecdhProvider).publicKey;

    if(privateKey == null || publicKey == null) {
      print("_exchangeKey: ${privateKey == null}");
      print("_exchangeKey: ${publicKey == null}");
      return "";
    }

    context.showLoaderOverlay();
    
    var result = await ref.read(ecdhProvider.notifier).keyExchange(publicKey.toHex());
    var otherPartyPublicKey = result.when(
      completeWithValue: (value) {

        List<int> sharedSecretKey = [];
        print("value.data.publicKey: ${value.data.publicKey}");
        // print(value.data.encryptedKeyData);

        var otherPartyPublicKey = _genPublicKey(value.data.publicKey ?? "");        

        sharedSecretKey = computeSecret(privateKey, otherPartyPublicKey);

        print("sharedSecretKey: ${base64Encode(sharedSecretKey)}");
        print("sharedKey (from server): ${value.data.sharedKey}");

        // ref.read(ecdhProvider.notifier).updateData(
        //   otherPartyPublicKey: otherPartyPublicKey,
        //   sharedSecretKey: sharedSecretKey
        // );

        // ============================================================

        final base64Decoder = base64.decoder;
        var cipherText = base64Decoder.convert(value.data.encryptedKeyData ?? "");

        var iv = cipherText.getRange(0, 12).toList();
        var encryptedKeyData = cipherText.getRange(12, cipherText.length).toList();

        // print("nonce: ${iv.toString()}");
        // print("cipherText: ${cipherText.toString()}");
        // print("cipherText last-1: ${cipherText[cipherText.length-2]}");
        // print("cipherText last: ${cipherText.last}");

        // Test decrypt
        var data = _decryptAesGcm(value.data.sharedKey ?? "", base64Encode(encryptedKeyData), base64Encode(iv));

        print("data: $data");

        Map<String, dynamic> valueMap = jsonDecode(data);
        print("KeyId: ${valueMap["keyId"]}");

        ref.read(ecdhProvider.notifier).updateData(
          otherPartyPublicKey: otherPartyPublicKey,
          sharedSecretKey: sharedSecretKey,
          keyId: valueMap["keyId"]
        );

        return otherPartyPublicKey.toHex();
        
      }, 
      completeWithError: (error) {
        return "";
      }
    );

    await Future.delayed(const Duration(seconds: 1), () {
      context.hideLoaderOverlay();
    });

    return otherPartyPublicKey;
  }

  String _encrypt(String base64Key, String plainText) {
    final key = encrypt.Key.fromBase64(base64Key);
    // final key = encrypt.Key.fromLength(32);

    final iv = encrypt.IV.fromLength(12);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Encrypted data
    return encrypted.base64;
  }

  // String _decrypt(String base64Key, String cipherText) {
  //   final key = encrypt.Key.fromBase64(base64Key);
  //   // final key = encrypt.Key.fromLength(32);

  //   final iv = encrypt.IV.fromLength(12);

  //   final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

  //   final plainText = encrypter.decrypt64(cipherText, iv: iv);

  //   return plainText;
  // }

  String _encryptAesGcm(String base64Key, String plainText) {

    var cipherText = "";

    try {
      final key = encrypt.Key.fromBase64(base64Key);
      // final key = encrypt.Key.fromLength(32);

      final nonce = encrypt.IV.fromLength(12);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

      cipherText = encrypter.encrypt(plainText, iv: nonce).base64;

    } catch (e) {
      print(e.toString());
    }

    return cipherText;
  }

  String _decryptAesGcm(String base64Key, String cipherText, String nonce) {

    var plainText = "";
    
    try {
      final key = encrypt.Key.fromBase64(base64Key);
      // final key = encrypt.Key.fromLength(32);

      final iv = encrypt.IV.fromBase64(nonce);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

      plainText = encrypter.decrypt64(cipherText, iv: iv);

    } catch (e) {
      print(e.toString());
    }

    return plainText;
  }

  void _test() {
    print("ECDH");
    var ec = getP256(); // elliptic curves, NIST P-256 (FIPS 186-3, section D.2.3), also known as secp256r1 or prime256v1
    // var priv = ec.generatePrivateKey();
    // var pub = priv.publicKey;
    // print('privateKey: 0x$priv');
    // print('publicKey: 0x$pub');

    // ecdh
    var privateClient = ec.generatePrivateKey();
    var publicClient = privateClient.publicKey;
    var privateServer = ec.generatePrivateKey();
    var publicServer = privateServer.publicKey;
    
    // var secretClient = computeSecretHex(privateClient, publicServer);
    // var secretServer = computeSecretHex(privateServer, publicClient);
    // print('secretClient (hex): 0x$secretClient');
    // print('secretServer (hex): 0x$secretServer');
    // var val = hexToUint8List(secretClient);

    // Print client public key (send to backend)
    print(publicClient.curve.bitSize);
    print(publicClient.toHex());

    var val = hexToUint8List(publicClient.toHex());
    print(val);
    // ===========================================================

    // Compute shared key
    var secretClient = computeSecret(privateClient, publicServer);
    var secretServer = computeSecret(privateServer, publicClient);

    print(secretClient.length);
    print(secretServer.length);

    // Convert basr64 format
    var secretClientBase64 = base64Encode(secretClient);
    var secretServerBase64 = base64Encode(secretServer);
  
    print("secretClientBase64: $secretClientBase64");

    print("========================================================================");
    
    // AES
    print("AES");
    final plainText = "This is secret message";

    final key = encrypt.Key.fromBase64(secretClientBase64);
    // final key = encrypt.Key.fromLength(32);

    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    print(encrypted.base64);

    final decrypted = encrypter.decrypt64(encrypted.base64, iv: iv);

    print(decrypted);
  }

  Uint8List hexToUint8List(String hex) {
  if (hex.length % 2 != 0) {
    throw 'Odd number of hex digits';
  }
  var l = hex.length ~/ 2;
  var result = Uint8List(l);
  for (var i = 0; i < l; ++i) {
    var x = int.parse(hex.substring(2 * i, 2 * (i + 1)), radix: 16);
    if (x.isNaN) {
      throw 'Expected hex string';
    }
    result[i] = x;
  }
  return result;
}
}
