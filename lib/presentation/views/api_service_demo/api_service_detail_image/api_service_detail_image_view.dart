import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_state.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiServiceDetailImageViewArgs {
  final String image;

  ApiServiceDetailImageViewArgs({
    required this.image
  });
}

class ApiServiceDetailImageView extends ConsumerStatefulWidget {

  final ApiServiceDetailImageViewArgs args;

  const ApiServiceDetailImageView({
    required this.args,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiServiceDetailImageView();
}

class _ApiServiceDetailImageView  extends ConsumerState<ApiServiceDetailImageView> {

  final _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlankPageWidget(
      body: _image(widget.args.image)
    );
  }

  Widget _image(String image) {

    if(image.isEmpty) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: Center(
          child: Text(
            "Image not found",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.spMin,
              color: Colors.black87
            ),
          ),
        ),
      );
    }

    return InteractiveViewer(
      alignment: Alignment.center,
      boundaryMargin: EdgeInsets.all(MediaQuery.sizeOf(context).width),
      minScale: 1,
      maxScale: 4.0,
      scaleFactor: 1.0,
      transformationController: _transformationController,
      child: Hero(
        tag: "image_viewer",
        child: Image.network(
          image
        )
      )
    );
  }

}