import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeData>((ref) => AppTheme.getTheme());