import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer_controller.dart';
import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdfViewerProvider = StateNotifierProvider.autoDispose<PdfViewerController, PdfViewerState>(
  (ref) => PdfViewerController(),
);