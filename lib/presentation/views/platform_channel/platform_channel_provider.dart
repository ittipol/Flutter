import 'package:flutter_riverpod/flutter_riverpod.dart';

final batteryLevelProvider = StateProvider.autoDispose<String>((ref) => "");