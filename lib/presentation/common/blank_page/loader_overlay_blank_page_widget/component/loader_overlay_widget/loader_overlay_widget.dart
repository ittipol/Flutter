import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderOverlayWidget extends ConsumerStatefulWidget {

  const LoaderOverlayWidget({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoaderOverlayWidget();
}

class _LoaderOverlayWidget  extends ConsumerState<LoaderOverlayWidget> {  

  @override
  Widget build(BuildContext context) {

    final isShowLoaderOverlay = ref.watch(isShowLoaderOverlayProvider);
    
    return Visibility(
      visible: isShowLoaderOverlay,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height:  MediaQuery.sizeOf(context).height,
        color: Colors.black54.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: AppColor.primary
          )
        )
      ),
    );
  }
}