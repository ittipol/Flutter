import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/menu_entity.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_demo/presentation/common/responsive_layout/responsive_layout.dart';
import 'package:flutter_demo/presentation/common/responsive_layout_builder/responsive_layout_builder.dart';
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

  List<MenuEntity> menuList = [
    MenuEntity(title: "API Services", link: RouteName.apiServiceIndexView, icon: Icons.api),
    MenuEntity(title: "Local storage", link: RouteName.localStorageDemoView, loaderOverlay: true, icon: Icons.storage),
    MenuEntity(title: "UI widget", link: RouteName.uiDemoView, icon: Icons.phone_android),
    MenuEntity(title: "Responsive Design", link: RouteName.responsiveDesignView, icon: Icons.design_services),
    MenuEntity(title: "WebView", link: RouteName.webViewDemoView, icon: Icons.web),
    MenuEntity(title: "Sliver App Bar", link: RouteName.sliverAppBarView, icon: Icons.phone_android),
    // MenuEntity(title: "Platform Channel", link: RouteName.platformChannelView, icon: Icons.data_object),
  ];

  @override
  Widget build(BuildContext context) {    

    return BlankPageWidget(
      showBackBtn: false,
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)]
          // )
          color: Theme.of(context).colorScheme.background
        ),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),            
            child: Column(
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
                      // color: Theme.of(context)
                    )
                  ),
                ),
                const SelectingThemeSwitchView(),
                SizedBox(height: 8.h),
                ResponsiveLayoutBuilder(
                  mobileAll: (context) {
                    return _buttonGrid(context: context, width: MediaQuery.sizeOf(context).width);
                  },
                  webAppAll: (context) {
                    return ResponsiveLayout(
                      desktop: (context) {
                        return _buttonList(context: context, width: MediaQuery.sizeOf(context).width * 0.7);
                      },
                      mobile: (context) {
                        return _buttonList(context: context, width: MediaQuery.sizeOf(context).width);
                      }
                    );
                  }
                )
              ],
            ),
          )
        ),
      )
    );
  }

  Widget _buttonGrid({required BuildContext context, required double width}) {
    return GridView.builder(        
      itemCount: menuList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16/9, // Horizontal/Vertical
        mainAxisSpacing: 8.r,
        crossAxisSpacing: 8.r,
      ),
      itemBuilder: (BuildContext context, int index) {
        var menu = menuList[index];

        return GestureDetector(
          onTap: () async {

            if(menu.loaderOverlay) {
              ref.showLoaderOverlay();
      
              await Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushNamed(context, menu.link);
              });
            }else {
              Navigator.pushNamed(context, menu.link);
            }
            
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 5,
                  offset: const Offset(3, 3)
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,              
              children: [
                const Spacer(),
                Icon(
                  menu.icon ?? Icons.phone_android,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    menu.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.spMin,
                      color: Colors.black
                    ),
                  )
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buttonList({required BuildContext context, required double width}) {
    return Center(
      child: SizedBox(
        width: width,    
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuList.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            var menu = menuList[index];

            return GestureDetector(
              onTap: () async {
                if(menu.loaderOverlay) {
                  ref.read(isShowLoaderOverlayProvider.notifier).show();
          
                  await Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushNamed(context, menu.link);
                  });
                }else {
                  Navigator.pushNamed(context, menu.link);
                }
              },
              child: _button(text: menu.title, icon: menu.icon)
            );
          }
        )
      )
    );
  }

  Widget _button({required String text, IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(32))
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.phone_android,
            color: Colors.white,
          ),
          SizedBox(width: 8.r),
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