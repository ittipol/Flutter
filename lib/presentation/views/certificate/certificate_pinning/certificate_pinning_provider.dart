import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_controller.dart';
import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final certificatePinningProvider = StateNotifierProvider.autoDispose<CertificatePinningController, CertificatePinningState>(
  (ref) => CertificatePinningController()
);