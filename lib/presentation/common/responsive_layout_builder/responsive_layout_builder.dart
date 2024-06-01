import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/enum/screen_type.dart';
import 'package:flutter_demo/presentation/common/orientation_layout/orientation_layout.dart';
import 'package:flutter_demo/setting/app_screen_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayoutBuilder extends ConsumerStatefulWidget {

  final Widget Function(BuildContext)? desktopAll;
  final Widget Function(BuildContext)? desktopPortrait;
  final Widget Function(BuildContext)? desktopLandscape;
  final Widget Function(BuildContext)? tabletAll;
  final Widget Function(BuildContext)? tabletPortrait;
  final Widget Function(BuildContext)? tabletLandscape;
  final Widget Function(BuildContext)? mobileAll;
  final Widget Function(BuildContext)? mobilePortrait;
  final Widget Function(BuildContext)? mobileLandscape;
  final Widget Function(BuildContext)? watchAll;
  final Widget Function(BuildContext)? watchPortrait;
  final Widget Function(BuildContext)? watchLandscape;
  final Widget Function(BuildContext)? webAppAll;
  final Widget Function(BuildContext)? webAppPortrait;
  final Widget Function(BuildContext)? webAppLandscape;
  final Widget Function(BuildContext)? notMatchAll;
  final Widget Function(BuildContext)? notMatchPortrait;
  final Widget Function(BuildContext)? notMatchLandscape;

  const ResponsiveLayoutBuilder({
    this.desktopAll,
    this.desktopPortrait,
    this.desktopLandscape,
    this.tabletAll,
    this.tabletPortrait,
    this.tabletLandscape,
    this.mobileAll,
    this.mobilePortrait,
    this.mobileLandscape,
    this.watchAll,
    this.watchPortrait,
    this.watchLandscape,
    this.webAppAll,
    this.webAppPortrait,
    this.webAppLandscape,
    this.notMatchAll,
    this.notMatchPortrait,
    this.notMatchLandscape,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponsiveLayoutBuilder();
}

class _ResponsiveLayoutBuilder  extends ConsumerState<ResponsiveLayoutBuilder> {  

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("------------ =====> AppScreenSetting.isMobile [ ${AppScreenSetting.isMobile} ]");
      if(AppScreenSetting.isMobile) {
        debugPrint("##################################### =====> isMobile ====> Lock screen");
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {    
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        debugPrint("deviceScreenType: [ ${sizingInformation.deviceScreenType} ]");
        debugPrint("refinedSize: [ ${sizingInformation.refinedSize} ]");
        debugPrint("screenSize;: [ ${sizingInformation.screenSize} ]");

        if (kIsWeb) {
          debugPrint("##################################### =====> Web");
          AppScreenSetting.deviceScreenType = ScreenType.desktop;
          return OrientationLayout(
            all: widget.webAppAll,
            portrait: widget.webAppPortrait,
            landscape: widget.watchLandscape,
          );
        }else if(Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
          debugPrint("##################################### =====> Desktop");
          AppScreenSetting.deviceScreenType = ScreenType.desktop;
          return OrientationLayout(
            all: widget.desktopAll,
            portrait: widget.desktopPortrait,
            landscape: widget.desktopLandscape,
          );
        }else if(Platform.isAndroid || Platform.isIOS) {
          switch (sizingInformation.deviceScreenType) {
            case DeviceScreenType.desktop:
            case DeviceScreenType.tablet:
            debugPrint("##################################### =====> [Tablet]");
              AppScreenSetting.deviceScreenType = ScreenType.tablet;
              return OrientationLayout(
                all: widget.tabletAll,
                portrait: widget.tabletPortrait,
                landscape: widget.tabletLandscape,
              );
            case DeviceScreenType.mobile:
              debugPrint("##################################### =====> [Mobile]");
              AppScreenSetting.deviceScreenType = ScreenType.mobile;
              return OrientationLayout(
                all: widget.mobileAll,
                portrait: widget.mobilePortrait,
                landscape: widget.mobileLandscape,
              );
            case DeviceScreenType.watch:
              AppScreenSetting.deviceScreenType = ScreenType.watch;
              debugPrint("##################################### =====> [Watch]");
              return OrientationLayout(
                all: widget.watchAll,
                portrait: widget.watchPortrait,
                landscape: widget.watchLandscape,
              );
            default:            
          }
        }              

        AppScreenSetting.deviceScreenType = ScreenType.none;
        return OrientationLayout(
          all: widget.notMatchAll,
          portrait: widget.notMatchPortrait,
          landscape: widget.notMatchLandscape,
        );
      }
    );
  }

  void buildWithSpecificScreenSize(RefinedSize refinedSize) {
    switch (refinedSize) {
      case RefinedSize.small:        
        break;
      case RefinedSize.normal:        
        break;
      case RefinedSize.large:        
        break;
      case RefinedSize.extraLarge:        
        break;
      default:
    }
  }
}