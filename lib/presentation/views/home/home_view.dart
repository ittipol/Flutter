import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/menu_entity.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar.dart';
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

  final authenticationMenuList = [
    MenuEntity(title: "User Authentication", link: RouteName.userHomeView, icon: Icons.key),    
  ];

  final certificateMenuList = [
    MenuEntity(title: "Certificate Pinning", link: RouteName.certificatePinningView, icon: Icons.security),    
  ];

  final apiConnectionMenuList = [
    MenuEntity(title: "Pokemon index", link: RouteName.apiServiceIndexView, icon: Icons.catching_pokemon),
  ];

  final uiMenuList = [
    MenuEntity(title: "UI widget", link: RouteName.uiDemoView, icon: Icons.phone_android),
    MenuEntity(title: "Responsive Design", link: RouteName.responsiveDesignView, icon: Icons.design_services),
    MenuEntity(title: "Sliver App Bar", link: RouteName.sliverAppBarView, icon: Icons.table_rows),
    MenuEntity(title: "WebView", link: RouteName.webViewDemoView, icon: Icons.web),
    MenuEntity(title: "PDF Viewer", link: RouteName.pdfViewerView, icon: Icons.picture_as_pdf),
  ];

  final isolateMenuList = [
    MenuEntity(title: "Isolate", link: RouteName.isolateDemoView, icon: Icons.memory)
  ];

  final localStorageMenuList = [
    MenuEntity(title: "Local storage", link: RouteName.localStorageDemoView, loaderOverlay: true, icon: Icons.storage)
  ];

  @override
  Widget build(BuildContext context) {    

    return BlankPageWidget(
      showBackBtn: false,
      body: Container(
        decoration: BoxDecoration(          
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
                // Container(
                //   width: MediaQuery.sizeOf(context).width,
                //   alignment: Alignment.center,
                //   // decoration: BoxDecoration(
                //   //   border: Border(
                //   //     bottom: BorderSide(
                //   //       width: 2.r,
                //   //       color: Theme.of(context).colorScheme.secondary
                //   //     )
                //   //   )
                //   // ),
                //   child: Text(
                //     "Flutter",
                //     style: TextStyle(
                //       fontSize: 24.spMin
                //       // color: Theme.of(context)
                //     )
                //   ),
                // ),
                const UserAvatar(),
                SizedBox(height: 8.r),
                const SelectingThemeSwitchView(),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.centerLeft,                  
                  child: Text(
                    "Demo Menu",
                    style: TextStyle(
                      fontSize: 24.spMin,
                      fontWeight: FontWeight.w700
                    )
                  ),
                ),
                SizedBox(height: 8.r),
                _menuSection(
                  context: context,
                  title: "Authentication",
                  menuList: authenticationMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 8.r),
                _menuSection(
                  context: context,
                  title: "Certificate",
                  menuList: certificateMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 16.r),
                _menuSection(
                  context: context,
                  title: "API Connection",
                  menuList: apiConnectionMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 16.r),
                _menuSection(
                  context: context,
                  title: "UI",
                  menuList: uiMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 16.r),
                _menuSection(
                  context: context,
                  title: "Isolate",
                  menuList: isolateMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 16.r),
                _menuSection(
                  context: context,
                  title: "Local storage",
                  menuList: localStorageMenuList,
                  width: MediaQuery.sizeOf(context).width
                ),
                SizedBox(height: 32.r),                
                // ResponsiveLayoutBuilder(
                //   mobileAll: (context) {
                //     return _buttonGrid(context: context, width: MediaQuery.sizeOf(context).width);
                //   },
                //   webAppAll: (context) {
                //     return ResponsiveLayout(
                //       desktop: (context) {
                //         return _buttonList(context: context, width: MediaQuery.sizeOf(context).width * 0.7);
                //       },
                //       mobile: (context) {
                //         return _buttonList(context: context, width: MediaQuery.sizeOf(context).width);
                //       }
                //     );
                //   }
                // )
              ],
            ),
          )
        ),
      )
    );
  }

  Widget _menuSection({required BuildContext context, required String title, required List<MenuEntity> menuList, required double width}) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2.r,
                color: Theme.of(context).colorScheme.secondary
              )
            )
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.spMin,
              fontWeight: FontWeight.w700
            )
          ),
        ),
        SizedBox(height: 16.r),
        _buttonGrid(context: context, menuList: menuList ,width: width)
      ]
    );
  }

  Widget _buttonGrid({required BuildContext context, required List<MenuEntity> menuList, required double width}) {
    return GridView.builder(        
      itemCount: menuList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9/10, // Horizontal/Vertical
        mainAxisSpacing: 16.r,
        crossAxisSpacing: 16.r,
      ),
      itemBuilder: (BuildContext context, int index) {
        var menu = menuList[index];

        return GestureDetector(
          onTap: () async {

            if(menu.loaderOverlay) {
              context.showLoaderOverlay();
      
              await Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushNamed(context, menu.link);
              });
            }else {
              Navigator.pushNamed(context, menu.link);
            }
            
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Color(0xFFF5F3FF)             
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,              
              children: [
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFFFFCC70), Color(0xFFC850C0), Color(0xFF4158D0)]
                    )
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Icon(
                    menu.icon ?? Icons.phone_android,
                    color: Colors.white,
                    size: 40.spMin,
                  ),
                ),
                SizedBox(height: 24.r),
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

  // Widget _buttonList({required BuildContext context, required double width}) {
  //   return Center(
  //     child: SizedBox(
  //       width: width,    
  //       child: ListView.separated(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: menuList.length,
  //         separatorBuilder: (context, index) => SizedBox(height: 16.r),
  //         itemBuilder: (context, index) {
  //           var menu = menuList[index];

  //           return GestureDetector(
  //             onTap: () async {
  //               if(menu.loaderOverlay) {
  //                 ref.read(isShowLoaderOverlayProvider.notifier).show();
          
  //                 await Future.delayed(const Duration(seconds: 2), () {
  //                   Navigator.pushNamed(context, menu.link);
  //                 });
  //               }else {
  //                 Navigator.pushNamed(context, menu.link);
  //               }
  //             },
  //             child: _button(text: menu.title, icon: menu.icon)
  //           );
  //         }
  //       )
  //     )
  //   );
  // }

  // Widget _button({required String text, IconData? icon}) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
  //     width: MediaQuery.sizeOf(context).width,
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).colorScheme.primary,
  //       borderRadius: const BorderRadius.all(Radius.circular(32))
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(
  //           icon ?? Icons.phone_android,
  //           color: Colors.white,
  //         ),
  //         SizedBox(width: 8.r),
  //         Expanded(
  //           child: Text(
  //             text,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               fontSize: 16.spMin,
  //               color: Colors.white
  //             ),
  //           )
  //         ),
  //         SizedBox(width: 8.w),
  //         const Icon(
  //           Icons.chevron_right,
  //           color: Colors.white,
  //         ),
  //       ],
  //     ),
  //   );
  // }

}