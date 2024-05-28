import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_article_list/component_article_list_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_grid/component_grid_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    // WidgetsBinding.instance.addPostFrameCallback((_) async {});     
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    

    return BlankPageWidget(
      showBackBtn: false,
      appBar: AppBar(
        title: const Text('App Bar'),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,      
        leading: BackButton(
          onPressed: () {
            if(Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
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
              SizedBox(height: 16.h),
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
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)
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
                    bottom: BorderSide(width: 1.w, color: AppColor.primary.percentAlpha(50))
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
                            fontSize: 16.sp,
                            color: Colors.black
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
                            fontSize: 16.sp,
                            color: Colors.black
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
                    showBackBtn: true,
                    body: Text(
                      "Full screen modal dialog",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black
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
                    showBackBtn: true,
                    body: Text(
                      "Fixed screen modal dialog",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black
                      )
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.4
                  );
                },              
                child: _button(text: "Show Fixed screen modal dialog"),
              ),
              SizedBox(height: 16.h),
              const Divider(
                thickness: 1,
                color: AppColor.primary,
              ),
              SizedBox(height: 16.h),
              const ComponentButtonGroupAndListView(),
              SizedBox(height: 16.h),
              const ComponentArticleListView(),
              SizedBox(height: 16.h),
              const ComponentGridView()
            ],
          ),
        )
      )      
    );
  }

  Widget _button({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 30.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.all(Radius.circular(32))
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