import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeSelectProvider = StateProvider.autoDispose<bool>((ref) => false);