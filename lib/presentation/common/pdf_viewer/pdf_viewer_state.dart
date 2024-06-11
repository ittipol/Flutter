import 'dart:typed_data';

enum PdfViewerStateStatus { initial, loading, success, failure }

class PdfViewerState {

  final PdfViewerStateStatus status;
  final String? filePath;
  final Uint8List? byteArray;

  PdfViewerState({
    this.status = PdfViewerStateStatus.initial,
    this.filePath,
    this.byteArray,
  });

  PdfViewerState copyWith({PdfViewerStateStatus? status, String? filePath, Uint8List? byteArray}) => PdfViewerState(
    status: status ?? this.status,
    filePath: filePath ?? this.filePath,
    byteArray: byteArray ?? this.byteArray,
  );
}
