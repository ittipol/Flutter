import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/scaffold_blank_page_widget/scaffold_blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlankPageWidget extends ConsumerStatefulWidget {

  final Key? scaffoldBlankPageKey;
  final AppBarWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool drawerEnableOpenDragGesture;
  final Widget? bottomSheet;  
  final bool resizeToAvoidBottomInset;
  final bool showBackBtn;
  final void Function()? onTabBackBtn;

  const BlankPageWidget({
    this.scaffoldBlankPageKey,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.drawerEnableOpenDragGesture = false,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
    this.showBackBtn = true,
    this.onTabBackBtn,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlankPageWidget();
}

class _BlankPageWidget  extends ConsumerState<BlankPageWidget> {

  bool loading = false;
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldBlankPageWidget(
      scaffoldBlankPageKey: widget.scaffoldBlankPageKey,
      appBar: widget.appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.showBackBtn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [     
                SizedBox(height: 8.r),                 
                GestureDetector(
                  onTap: () {                      
                    if (widget.onTabBackBtn != null) {
                      widget.onTabBackBtn?.call();
                    } else {
                      _delayedTab(() {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    margin: EdgeInsets.only(left: 16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.chevron_left),
                  ),
                ),
                SizedBox(height: 8.r)
              ]
            )
          ),
          Expanded(
            child: widget.body ?? Container()
          )
        ]
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      bottomSheet: widget.bottomSheet,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset
    );
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 500)).then((v) {loading = false;});
  }
}