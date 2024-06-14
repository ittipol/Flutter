import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_article_list/component_article_list_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_grid/component_grid_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final GlobalKey<ScaffoldState> scaffoldBlankPageKey = GlobalKey();

class UiDemoView extends ConsumerStatefulWidget {

  const UiDemoView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UiDemoView();
}

class _UiDemoView  extends ConsumerState<UiDemoView> with WidgetsBindingObserver {  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:        
        debugPrint(">>>>>> didChangeAppLifecycleState =====> [ ${AppLifecycleState.resumed.name} ]");      
        break;
      case AppLifecycleState.inactive:
        debugPrint(">>>>>> didChangeAppLifecycleState =====> [ ${AppLifecycleState.inactive.name} ]");
        break;
      case AppLifecycleState.paused:
        debugPrint(">>>>>> didChangeAppLifecycleState =====> [ ${AppLifecycleState.paused.name} ]");
        break;
      case AppLifecycleState.detached:
        debugPrint(">>>>>> didChangeAppLifecycleState =====> [ ${AppLifecycleState.detached.name} ]");
        break;
      case AppLifecycleState.hidden:
        debugPrint(">>>>>> didChangeAppLifecycleState =====> [ ${AppLifecycleState.hidden.name} ]");
    }    
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    

    return BlankPageWidget(
      scaffoldBlankPageKey: scaffoldBlankPageKey,
      showBackBtn: false,
      appBar: AppBarWidget(
        titleText: "APP BAR",
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ModalDialogWidget.showModalDialogWithOkCancelButton(
                context: context,
                title: "Search",
                body: const TextField(
                  style: TextStyle(color: Colors.black),
                ),
                onTapCancel: () {
                  ModalDialogWidget.closeModalDialog(context: context);
                },
                onTapOk: () async {
                  ModalDialogWidget.closeModalDialog(context: context);

                  context.showLoaderOverlay();
                  await Future.delayed(const Duration(seconds: 2), () {
                    context.hideLoaderOverlay();
                  });
                },
                useInsetPadding: true
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              scaffoldBlankPageKey.currentState!.openEndDrawer();
            },
          )
        ]
      ),
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
      ),
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  "Menu",
                  style: const TextStyle().copyWith(
                    color: Colors.black,
                    fontSize: 32.spMin
                  )
                ),
              ),              
              _drawerMenuItem(title: "Log In", icon: Icons.key, onTap: () {
                Navigator.pushNamed(context, RouteName.userHomeView);
              }),
              _drawerMenuItem(title: "Isolate", icon: Icons.memory, onTap: () {
                Navigator.pushNamed(context, RouteName.isolateDemoView);
              }),
              _drawerMenuItem(title: "Local storage", icon: Icons.storage, onTap: () {
                Navigator.pushNamed(context, RouteName.localStorageDemoView);
              })
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          padding: EdgeInsets.all(8.r),
          color: Colors.transparent,
          child: ElevatedButton(
            onPressed: () async {
              final value = await Helper.checkUrlActive(ApiBaseUrl.localhostWebAppBaseUrl);
              
              if(value) {
                if(context.mounted) {
                  Navigator.pushNamed(context, RouteName.uiDemoWebView);
                }                
              }else {
                if(context.mounted) {
                  ModalDialogWidget.showModalDialogWithOkButton(
                    context: context,
                    body: Text(
                      "On the next page, It will open a website from localhost. Please start a web server",
                      textAlign: TextAlign.center,
                      style: const TextStyle().copyWith(
                        fontSize: 16.spMin,
                        color: Colors.black
                      ),
                    ),
                    useInsetPadding: true,
                    onTap: () {
                      ModalDialogWidget.closeModalDialog(context: context);
                    }
                  );
                }
              }
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade400,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              elevation: 0,
            ),
            child: SizedBox(
              height: 40.r,
              child: Center(
                child: Text(
                  "Next Page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  )
                ),
              )
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
        strokeWidth: 2,
        displacement: 20,
        // edgeOffset: 20,
        onRefresh: () async {
          debugPrint("onRefresh ====>");
        },
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 16.r),
              CarouselSlider(
                options: CarouselOptions(
                  height: 400.r,
                  // viewportFraction: 1
                ),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                        ),
                        child: Center(
                          child: Text(
                            "Title $i",
                            style: TextStyle(
                              fontSize: 24.spMin,
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
              SizedBox(height: 16.r),            
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.w, color: AppColor.primary.percentAlpha(50))
                  )
                ),
                child: Text(
                  "Modal dialog",
                  style: TextStyle(
                    fontSize: 24.spMin
                  )
                )
              ),
              SizedBox(height: 8.r),
              Text(
                "Modal dialog with one button",
                style: TextStyle(
                  fontSize: 16.spMin
                )
              ),
              SizedBox(height: 4.r),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ModalDialogWidget.showModalDialogWithOkButton(
                        context: context,
                        title: "Modal dialog with one button #1",
                        onTap: () {
                          ModalDialogWidget.closeModalDialog(context: context);
                        }
                      );
                    },
                    child: _button(text: "Show modal dialog #1"),
                  ),
                  SizedBox(height: 8.r),
                  GestureDetector(
                    onTap: () {
                      ModalDialogWidget.showModalDialogWithOkButton(
                        context: context,
                        title: "Modal dialog with one button #2",
                        body: Text(
                          "(fullScreenWidth = true and useInsetPadding = true)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.spMin,
                            color: Colors.black
                          )
                        ),
                        onTap: () {
                          ModalDialogWidget.closeModalDialog(context: context);
                        },
                        useInsetPadding: true,
                        fullScreenWidth: true
                      );
                    },
                    child: _button(text: "Show modal dialog #2"),
                  ),
                ],
              ),
              SizedBox(height: 8.r),
              Text(
                "Modal dialog with two buttons",
                style: TextStyle(
                  fontSize: 16.spMin
                )
              ),
              SizedBox(height: 4.r),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ModalDialogWidget.showModalDialogWithOkCancelButton(
                        context: context,
                        title: "Modal dialog with two buttons #1",
                        onTapCancel: () {
                          ModalDialogWidget.closeModalDialog(context: context);
                        }
                      );
                    },
                    child: _button(text: "Show modal dialog #1"),
                  ),
                  SizedBox(height: 8.r),
                  GestureDetector(
                    onTap: () {
                      ModalDialogWidget.showModalDialogWithOkCancelButton(
                        context: context,
                        title: "Modal dialog with two buttons #2",
                        body: Text(
                          "(fullScreenWidth = true and useInsetPadding = true)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.spMin,
                            color: Colors.black
                          )
                        ),
                        onTapCancel: () {
                          ModalDialogWidget.closeModalDialog(context: context);
                        },
                        useInsetPadding: true,
                        fullScreenWidth: true
                      );
                    },
                    child: _button(text: "Show modal dialog #2"),
                  ),
                ],
              ),
              SizedBox(height: 8.r),
              Text(
                "Full screen modal dialog",
                style: TextStyle(
                  fontSize: 16.spMin
                )
              ),
              SizedBox(height: 4.r),
              GestureDetector(
                onTap: () {
                  ModalDialogWidget.showModalDialogFullScreen(
                    context: context,
                    showBackBtn: true,
                    body: Text(
                      "Full screen modal dialog",
                      style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.black
                      )
                    )
                  );
                },              
                child: _button(text: "Show full screen modal dialog"),
              ),
              SizedBox(height: 8.r),
              Text(
                "Fixed screen modal dialog",
                style: TextStyle(
                  fontSize: 16.spMin
                )
              ),
              SizedBox(height: 4.r),
              GestureDetector(
                onTap: () {
                  ModalDialogWidget.showFixedScreenModalDialog(
                    context: context,
                    showBackBtn: true,
                    body: Text(
                      "Fixed screen modal dialog",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.black
                      )
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.4
                  );
                },              
                child: _button(text: "Show Fixed screen modal dialog"),
              ),
              SizedBox(height: 16.r),
              const Divider(
                thickness: 1,
                color: AppColor.primary,
              ),
              SizedBox(height: 16.r),
              const ComponentButtonGroupAndListView(),
              SizedBox(height: 16.r),
              const ComponentArticleListView(),
              SizedBox(height: 16.r),
              const ComponentGridView(),              

              Slidable(
                // Specify a key if the Slidable is dismissible.
                // key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  // dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) {                        
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {                        
                      },
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    )
                  ]
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      // flex: 2,
                      onPressed: (context) {                        
                      },
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                    SlidableAction(
                      onPressed: (context) {                        
                      },
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: const ListTile(                    
                    title: Text(
                      "Slide me",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.black,
                    ),
                  )
                )
              )
            ]
          )
        )
      )
    );
  }

  GestureDetector _drawerMenuItem({required String title, required IconData icon, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.all(4.r),
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(vertical: 4.r),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(32))
          ),
          child: ListTile(
            leading: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFFFCC70), Color(0xFFC850C0), Color(0xFF4158D0)]
                )
              ),
              width: 32.r,
              height: 32.r,
              child: Icon(
                icon,
                color: Colors.white,
                size: 24.spMin
              ),
            ),
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle().copyWith(
                color: Colors.black,
                fontSize: 16.spMin
              )
            )
          )
        )
      )
    );
  }

  Widget _button({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      height: 32.r,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.all(Radius.circular(32))
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.spMin,
          color: Colors.white
        ),
      ),
    );
  }

}