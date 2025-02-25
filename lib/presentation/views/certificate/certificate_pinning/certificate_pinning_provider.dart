import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_controller.dart';
import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final certificatePinningProvider = StateNotifierProvider.autoDispose<CertificatePinningController, CertificatePinningState>(
  (ref) => CertificatePinningController()
);

final certificatePinningServer1IsActiveUrlProvider = StateProvider.autoDispose<bool?>((ref) => null);
final certificatePinningServer2IsActiveUrlProvider = StateProvider.autoDispose<bool?>((ref) => null);