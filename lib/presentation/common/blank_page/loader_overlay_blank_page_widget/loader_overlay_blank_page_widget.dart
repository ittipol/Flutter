import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/component/loader_overlay_widget/loader_overlay_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderOverlayBlankPageWidget extends ConsumerStatefulWidget {

  final Widget? body;

  const LoaderOverlayBlankPageWidget({
    this.body,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoaderOverlayBlankPageWidget();
}

class _LoaderOverlayBlankPageWidget  extends ConsumerState<LoaderOverlayBlankPageWidget> {  

  @override
  Widget build(BuildContext context) {    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.body ?? Container(),
          const LoaderOverlayWidget()
        ]
      )
    );
  }
}