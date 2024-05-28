import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiDemoArticleViewArgs {

  final int id;
  final String image;
  final String title;
  final String tag;

  UiDemoArticleViewArgs({
    required this.id,
    required this.image,
    required this.title,
    required this.tag
  });

}

class UiDemoArticleView extends ConsumerStatefulWidget {

  final UiDemoArticleViewArgs args;

  const UiDemoArticleView({
    required this.args,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UiDemoArticleView();
}

class _UiDemoArticleView  extends ConsumerState<UiDemoArticleView> {

  @override
  Widget build(BuildContext context) {

    return BlankPageWidget(
      body: Column(
        children: [
          Hero(
            tag: widget.args.tag, 
            child: Image(image: AssetImage(widget.args.image))
          ),
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.args.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id donec ultrices tincidunt arcu non. Sed enim ut sem viverra aliquet eget sit. Ac tincidunt vitae semper quis lectus nulla at volutpat diam. Elementum sagittis vitae et leo duis. Nulla pellentesque dignissim enim sit amet venenatis. Dignissim cras tincidunt lobortis feugiat vivamus at. Ut pharetra sit amet aliquam id. Pretium nibh ipsum consequat nisl vel pretium lectus quam. Erat imperdiet sed euismod nisi porta. Est ultricies integer quis auctor. Dignissim suspendisse in est ante. Turpis in eu mi bibendum neque egestas congue quisque egestas. Elit at imperdiet dui accumsan sit. Faucibus ornare suspendisse sed nisi lacus sed. Maecenas pharetra convallis posuere morbi leo. Lectus proin nibh nisl condimentum id venenatis a. Ut tellus elementum sagittis vitae et leo duis ut diam. Cras sed felis eget velit.",
                      style: TextStyle(
                        fontSize: 12.sp
                      ),
                    )
                  ],
                )
              ),
            )
          )
        ],
      )
    );
  }

}