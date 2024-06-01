import 'package:flutter/material.dart';

class MenuEntity {
  final String title;
  final String link;
  final IconData? icon;
  final bool loaderOverlay;

  MenuEntity({
    required this.title,
    required this.link,
    this.icon,
    this.loaderOverlay = false
  });
}