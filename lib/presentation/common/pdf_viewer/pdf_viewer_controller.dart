import 'dart:typed_data';

import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfViewerController extends StateNotifier<PdfViewerState> {

  PdfViewerController() : super(PdfViewerState());

  void update({PdfViewerStateStatus? status, String? filePath, Uint8List? byteArray}) {
    state = state.copyWith(status: status,filePath: filePath, byteArray: byteArray);
  }
}