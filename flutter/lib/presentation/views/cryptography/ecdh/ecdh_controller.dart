import 'package:elliptic/elliptic.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcdhController extends StateNotifier<EcdhState> {

  EcdhController() : super(EcdhState());

  void updateData({PrivateKey? privateKey, PublicKey? publicKey, List<int>? sharedSecretKey, PublicKey? otherPartyPublicKey}) {
    state = state.copyWith(
      privateKey: privateKey,
      publicKey: publicKey,
      sharedSecretKey: sharedSecretKey,
      otherPartyPublicKey: otherPartyPublicKey
    );
  }

}