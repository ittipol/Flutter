import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/views/common/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_article_list/component_article_list_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiDemoView extends ConsumerStatefulWidget {

  const UiDemoView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UiDemoView();
}

class _UiDemoView  extends ConsumerState<UiDemoView> {

  @override
  Widget build(BuildContext context) {    

    return BlankPageWidget(
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400.h,
                viewportFraction: 1
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withAlpha(200)
                      ),
                      child: Center(
                        child: Text(
                          "Title $i",
                          style: TextStyle(
                            fontSize: 24.sp,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white
                          )
                        ),
                      )
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
            const ComponentOneView(),
            SizedBox(height: 16.h),
            const ComponentDetailListView()
          ],
        ),
      )
    );

  }

}