import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenCaptureView extends ConsumerStatefulWidget {

  const ScreenCaptureView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenCaptureView();
}

class _ScreenCaptureView  extends ConsumerState<ScreenCaptureView> {

  final GlobalKey _globalKey = GlobalKey();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    _globalKey.currentState?.dispose();    
  }

  @override
  Widget build(BuildContext context) {

    return BlankPageWidget(                
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.w, color: AppColor.primary.percentAlpha(50))
              )
            ),
            child: Text(
              "Screen Capture",
              style: TextStyle(
                fontSize: 24.sp
              )
            )
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.w, color: AppColor.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Image(image: AssetImage(Assets.images.detail.path)),
                      SizedBox(height: 8.h),
                      Text(
                        "Next-Gen Graphics Tech Demo",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.black
                        )
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: SingleChildScrollView(
                          clipBehavior: Clip.antiAlias,
                          physics: const ClampingScrollPhysics(),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id donec ultrices tincidunt arcu non. Sed enim ut sem viverra aliquet eget sit. Ac tincidunt vitae semper quis lectus nulla at volutpat diam. Elementum sagittis vitae et leo duis. Nulla pellentesque dignissim enim sit amet venenatis. Dignissim cras tincidunt lobortis feugiat vivamus at. Ut pharetra sit amet aliquam id. Pretium nibh ipsum consequat nisl vel pretium lectus quam. Erat imperdiet sed euismod nisi porta. Est ultricies integer quis auctor. Dignissim suspendisse in est ante. Turpis in eu mi bibendum neque egestas congue quisque egestas. Elit at imperdiet dui accumsan sit. Faucibus ornare suspendisse sed nisi lacus sed. Maecenas pharetra convallis posuere morbi leo. Lectus proin nibh nisl condimentum id venenatis a. Ut tellus elementum sagittis vitae et leo duis ut diam. Cras sed felis eget velit.",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black
                            )
                          ),
                        ),
                      )
                    ]
                  )
                )
              )
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              _delayedTab(() async {
                ref.read(isShowLoaderOverlayProvider.notifier).show();
                await saveScreenCapture();
                await Future.delayed(const Duration(seconds: 2), () {
                  ref.read(isShowLoaderOverlayProvider.notifier).hide();
                });
              });              
            },
            child: Container(
              alignment: Alignment.center,                            
              decoration: const BoxDecoration(
                color: AppColor.primary
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const Text(
                "Capture screen",
                style: TextStyle(
                  color: Colors.white
                )
              )
            )
          )
        ],
      ),
    );
  }

  Future<bool> saveScreenCapture() async {

    var imageByte = await _createScreenCapture();

    if(imageByte == null) {
      return false;
    }

    debugPrint(imageByte.length.toString());
    // await _saveToLocalStorage(imageByte);

    return true;
  }

  Future<Uint8List?> _createScreenCapture() async {
    ui.Image? image;

    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    
    try {
      image = await boundary.toImage();
      var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (exception) {
      await Future.delayed(const Duration(milliseconds: 10));
      return await _createScreenCapture();
    }    
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 500)).then((v) {loading = false;});
  }
}