import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayout extends ConsumerStatefulWidget {

  final Widget Function(BuildContext)? mobilePortrait;
  final Widget Function(BuildContext)? mobileLandscape;
  final Widget Function(BuildContext)? tabletPortrait;
  final Widget Function(BuildContext)? tabletLandscape;
  final Widget Function(BuildContext)? desktopPortrait;
  final Widget Function(BuildContext)? desktopLandscape;
  final Widget Function(BuildContext)? watchPortrait;
  final Widget Function(BuildContext)? watchLandscape;

  const ResponsiveLayout({
    this.mobilePortrait,
    this.mobileLandscape,
    this.tabletPortrait,
    this.tabletLandscape,
    this.desktopPortrait,
    this.desktopLandscape,
    this.watchPortrait,
    this.watchLandscape,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponsiveLayout();
}

class _ResponsiveLayout  extends ConsumerState<ResponsiveLayout> {  

  @override
  Widget build(BuildContext context) {    
    return ScreenTypeLayout.builder(
      mobile: (ctx) {
        return OrientationLayoutBuilder(
          portrait: (ctx) {
            return widget.mobilePortrait?.call(ctx) ?? Container();
          },
          landscape: (ctx) {
            return widget.mobileLandscape?.call(ctx) ?? Container();
          }
        );
      },
      tablet: (ctx) {
        return OrientationLayoutBuilder(
          portrait: (ctx) {
            return widget.tabletPortrait?.call(ctx) ?? Container();
          },
          landscape: (ctx) {
            return widget.tabletLandscape?.call(ctx) ?? Container();
          }
        );
      },
      desktop: (ctx) {
        return OrientationLayoutBuilder(
          portrait: (ctx) {
            return widget.desktopPortrait?.call(ctx) ?? Container();
          },
          landscape: (ctx) {
            return widget.desktopLandscape?.call(ctx) ?? Container();
          }
        );
      },
      watch: (ctx) {
        return OrientationLayoutBuilder(
          portrait: (ctx) {
            return widget.watchPortrait?.call(ctx) ?? Container();
          },
          landscape: (ctx) {
            return widget.watchLandscape?.call(ctx) ?? Container();
          }
        );
      }
    );
  }
}