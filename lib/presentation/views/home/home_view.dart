import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/common/blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends ConsumerStatefulWidget {

  const HomeView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeView();
}

class _HomeView  extends ConsumerState<HomeView> {

  @override
  Widget build(BuildContext context) {

    return BlankPageWidget(
      displayBackBtn: false,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.only(bottom: 24.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2.r,
                    color: Theme.of(context).colorScheme.primary
                  )
                )
              ),
              child: Text(
                "Flutter Demo",
                style: TextStyle(
                  fontSize: 24.sp
                )
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.apiServiceIndexView);
              },
              child: _button(text: "Demo API Service")
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.uiDemoView);
              },
              child: _button(text: "Demo UI widget")
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.webViewDemoView);
              },
              child: _button(text: "Demo webview")
            )
          ],
        ),
      ),
    );

  }

  Widget _button({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(500),
        borderRadius: BorderRadius.all(Radius.circular(32.r))
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white
              ),
            )
          ),
          SizedBox(width: 8.w),
          Text(
            ">",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp
            ),
          )
        ],
      ),
    );
  }

}