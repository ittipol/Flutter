import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_controller.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ecdhProvider = StateNotifierProvider.autoDispose<EcdhController, EcdhState>(
  (ref) => EcdhController(),  
);