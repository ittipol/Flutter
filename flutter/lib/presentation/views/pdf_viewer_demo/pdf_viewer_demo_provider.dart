import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdfViewerDemoIsActiveUrlProvider = StateProvider.autoDispose<bool?>((ref) => null);
final pdfViewerDemoIsLoadedProvider = StateProvider.autoDispose<bool>((ref) => false);