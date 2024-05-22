import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/views/common/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/common/modal_dialog/modal_dialog_widget.dart';
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
                // viewportFraction: 1
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
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.w, color: Theme.of(context).colorScheme.primary.withAlpha(100))
                )
              ),
              child: Text(
                "Modal dialog",
                style: TextStyle(
                  fontSize: 24.sp
                )
              )
            ),
            SizedBox(height: 8.h),
            Text(
              "Modal dialog with one button",
              style: TextStyle(
                fontSize: 16.sp
              )
            ),
            SizedBox(height: 4.h),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ModalDialogWidget().showModalDialogWithOkButton(
                      context: context,
                      title: "Modal dialog with one button #1",
                      onTap: () {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      }
                    );
                  },
                  child: _button(text: "Show modal dialog #1"),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    ModalDialogWidget().showModalDialogWithOkButton(
                      context: context,
                      title: "Modal dialog with one button #2",
                      body: Text(
                        "(fullScreenWidth = true and useInsetPadding = true)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp
                        )
                      ),
                      onTap: () {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      },
                      useInsetPadding: true,
                      fullScreenWidth: true
                    );
                  },
                  child: _button(text: "Show modal dialog #2"),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Modal dialog with two buttons",
              style: TextStyle(
                fontSize: 16.sp
              )
            ),
            SizedBox(height: 4.h),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ModalDialogWidget().showModalDialogWithOkCancelButton(
                      context: context,
                      title: "Modal dialog with two buttons #1",
                      onTapCancel: () {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      }
                    );
                  },
                  child: _button(text: "Show modal dialog #1"),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    ModalDialogWidget().showModalDialogWithOkCancelButton(
                      context: context,
                      title: "Modal dialog with two buttons #2",
                      body: Text(
                        "(fullScreenWidth = true and useInsetPadding = true)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp
                        )
                      ),
                      onTapCancel: () {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      },
                      useInsetPadding: true,
                      fullScreenWidth: true
                    );
                  },
                  child: _button(text: "Show modal dialog #2"),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Full screen modal dialog",
              style: TextStyle(
                fontSize: 16.sp
              )
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () {
                ModalDialogWidget().showModalDialogFullScreen(
                  context: context,
                  displayBackBtn: true,
                  body: Text(
                    "Full screen modal dialog",
                    style: TextStyle(
                      fontSize: 24.sp
                    )
                  )
                );
              },              
              child: _button(text: "Show full screen modal dialog"),
            ),
            SizedBox(height: 8.h),
            Text(
              "Fixed screen modal dialog",
              style: TextStyle(
                fontSize: 16.sp
              )
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () {
                ModalDialogWidget().showFixedScreenModalDialog(
                  context: context,
                  displayBackBtn: true,
                  body: Text(
                    "Fixed screen modal dialog",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24.sp
                    )
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.4
                );
              },              
              child: _button(text: "Show Fixed screen modal dialog"),
            ),

            SizedBox(height: 8.h),
            Divider(thickness: 12.h, color: Colors.grey.shade100),
            SizedBox(height: 8.h),
            const ComponentOneView(),
            SizedBox(height: 16.h),
            const ComponentDetailListView()
          ],
        ),
      )
    );
  }

  Widget _button({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 30.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(32.r))
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white
        ),
      ),
    );
  }

}