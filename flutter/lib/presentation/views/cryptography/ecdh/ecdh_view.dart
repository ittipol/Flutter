import 'dart:convert';
import 'dart:typed_data';

import 'package:elliptic/ecdh.dart';
import 'package:elliptic/elliptic.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
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
  
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Future.delayed(const Duration(seconds: 1), () {
    //     context.hideLoaderOverlay();
    //   });
    // });
  }

  // @override
  // void dispose(){
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(ecdhProvider);

    return BlankPageWidget(      
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
              _text("Plain text", ""),
              SizedBox(height: 8.h),
              _text("Cipher text (encrypted data)", ""),
              SizedBox(height: 8.h),
              _text("Decrypted data", ""),              
              SizedBox(height: 32.h),
              _button("Generate key pair", () {
                var privateKey = _genKeyPair();
                var publicKey = privateKey.publicKey;

                ref.read(ecdhProvider.notifier).updateData(
                  privateKey: privateKey,
                  publicKey: publicKey
                );

              }),
              SizedBox(height: 24.h),
              _button("Exchange public key", () {
                
                List<int>? sharedSecretKey;

                var otherPartyPublicKeyHex = _exchangeKey();
                var otherPartyPublicKey = _genPublicKey(otherPartyPublicKeyHex);                  

                if(state.privateKey != null) {
                  sharedSecretKey = computeSecret(state.privateKey!, otherPartyPublicKey);
                }

                ref.read(ecdhProvider.notifier).updateData(
                  otherPartyPublicKey: otherPartyPublicKey,
                  sharedSecretKey: sharedSecretKey
                );

              }),
              SizedBox(height: 24.h),
              _button("AES encryption and send to server", () {
                
                // call api and return encrypted data

                // decrypt data with shared secret key

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

  String _exchangeKey() {
    // Call Api to exchange key to other party
    return "04778aae16b613d212ddfc9d62cb5784d5c665746faea92d65b5699cd21b14fc75d4fd2e961d50e746334b1d5640700508fdda2a7658e266f4ec7ea53ea69d205a";
  }

  String _encrypt(String Base64Key, String plainText) {
    final key = encrypt.Key.fromBase64(Base64Key);
    // final key = encrypt.Key.fromLength(32);

    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Encrypted data
    return encrypted.base64;
  }

  String _decrypt(String Base64Key, String cipherText) {
    final key = encrypt.Key.fromBase64(Base64Key);
    // final key = encrypt.Key.fromLength(32);

    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final plainText = encrypter.decrypt64(cipherText, iv: iv);

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
