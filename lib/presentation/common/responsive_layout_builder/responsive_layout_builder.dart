import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayoutBuilder extends ConsumerStatefulWidget {

  final MaterialAppBlankWidget desktop;
  final MaterialAppBlankWidget tablet;
  final MaterialAppBlankWidget mobile;
  final MaterialAppBlankWidget watch;
  final MaterialAppBlankWidget notMatch;

  const ResponsiveLayoutBuilder({
    required this.desktop,
    required this.tablet,
    required this.mobile,
    required this.watch,
    required this.notMatch,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponsiveLayoutBuilder();
}

class _ResponsiveLayoutBuilder  extends ConsumerState<ResponsiveLayoutBuilder> {  

  @override
  Widget build(BuildContext context) {    
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        debugPrint("deviceScreenType: [ ${sizingInformation.deviceScreenType} ]");
        debugPrint("refinedSize: [ ${sizingInformation.refinedSize} ]");
        debugPrint("screenSize;: [ ${sizingInformation.screenSize} ]");
        
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.desktop:

            if (kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
              return widget.desktop;
            }else if(Platform.isAndroid || Platform.isIOS) {
              return widget.tablet;
            }else {
              return widget.notMatch;
            }
            
          case DeviceScreenType.tablet:

            // SystemChrome.setPreferredOrientations([
            //   DeviceOrientation.landscapeRight,
            //   DeviceOrientation.landscapeLeft,
            //   DeviceOrientation.portraitUp,
            //   DeviceOrientation.portraitDown,
            // ]);

            return widget.tablet;
          case DeviceScreenType.mobile:

            // SystemChrome.setPreferredOrientations([
            //   DeviceOrientation.portraitUp,
            //   DeviceOrientation.portraitDown,
            // ]);

            return widget.mobile;
          case DeviceScreenType.watch:
            return widget.watch;
          default:
            return widget.notMatch;
        }
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