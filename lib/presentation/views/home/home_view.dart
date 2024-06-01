import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_demo/presentation/common/responsive_layout/responsive_layout.dart';
import 'package:flutter_demo/presentation/views/home/components/selecting_theme_switch/selecting_theme_switch_view.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
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

    // var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    // var screenHeight = screenSize.height;
    // var clientHeight = screenHeight - kToolbarHeight;

    return BlankPageWidget(
      showBackBtn: false,
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        physics: const ClampingScrollPhysics(),
        child: ResponsiveLayout(
          desktop: (ctx) {
            return _buttonList(context: ctx, width: MediaQuery.sizeOf(ctx).width * 0.7);
          },
          mobile: (ctx) {
            return _buttonList(context: ctx, width: MediaQuery.sizeOf(ctx).width);
          },
        )
      )
    );
  }

  Widget _buttonList({required BuildContext context, required double width}) {
    return Center(
      child: Container(
          width: width,
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
                      color: Theme.of(context).colorScheme.secondary
                    )
                  )
                ),
                child: Text(
                  "Flutter",
                  style: TextStyle(
                    fontSize: 24.spMin
                  )
                ),
              ),
              const SelectingThemeSwitchView(),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.apiServiceIndexView);
                },
                child: _button(text: "API Services")
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () async {
                  ref.read(isShowLoaderOverlayProvider.notifier).show();
      
                  await Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushNamed(context, RouteName.localStorageDemoView);
                  });
                },
                child: _button(text: "Local storage")
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.uiDemoView);
                },
                child: _button(text: "UI widget")
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.responsiveDesignView);
                },
                child: _button(text: "Responsive Design")
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.webViewDemoView);
                },
                child: _button(text: "WebView")
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.sliverAppBarView);
                },
                child: _button(text: "Sliver App Bar")
              )
            ]
          )
        ),
    );
  }

  Widget _button({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(32))
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.spMin,
                color: Colors.white
              ),
            )
          ),
          SizedBox(width: 8.w),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

}