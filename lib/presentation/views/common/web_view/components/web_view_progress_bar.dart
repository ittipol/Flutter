import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/presentation/views/common/web_view/web_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewProgressBar extends ConsumerStatefulWidget {

  const WebViewProgressBar({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewProgressBar();
}

class _WebViewProgressBar  extends ConsumerState<WebViewProgressBar> with TickerProviderStateMixin  {

  late AnimationController _animationController;

  @override
  void dispose() {    
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _animationController = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
    )..addListener(() {
      setState(() {});
    });

    // _animationController = AnimationController(
    //   /// [AnimationController]s can be created with `vsync: this` because of
    //   /// [TickerProviderStateMixin].
    //   vsync: this,
    // );

    super.initState();    
  }

  @override
  Widget build(BuildContext context) {

    final loadingPercentage = ref.watch(webViewProvider.select((value) => value.loadingPercentage));

    switch (loadingPercentage) {
      case 0:
          _animationController.animateTo(0.0, duration: const Duration(seconds: 0));  
        break;
          
      case 100:
          _animationController.animateTo(1.0, duration: const Duration(milliseconds: 200), curve: Curves.fastLinearToSlowEaseIn);
        break;

      default:
        _animationController.animateTo(loadingPercentage / 100.0, duration: const Duration(milliseconds: 200), curve: Curves.fastLinearToSlowEaseIn);
    }
    
    return LinearProgressIndicator(
      value: _animationController.value,
      backgroundColor: Colors.transparent,
      color: AppColor.primary.percentAlpha(95)
    );

  }  
}