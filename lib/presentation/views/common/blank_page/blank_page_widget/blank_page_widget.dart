import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/views/common/blank_page/scaffold_blank_page_widget/scaffold_blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlankPageWidget extends ConsumerStatefulWidget {

  final AppBar? appBar;
  final Widget? body;
  final bool resizeToAvoidBottomInset;
  final bool displayBackBtn;
  final void Function()? onTabBackBtn;

  const BlankPageWidget({
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset = false,
    this.displayBackBtn = true,
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
      appBar: widget.appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Visibility(
            visible: widget.displayBackBtn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                      
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
                    width: 24.w,
                    height: 24.w,
                    margin: EdgeInsets.only(left: 16.w, bottom: 4.w),                      
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.chevron_left),
                  ),
                ),
                SizedBox(height: 8.h)
              ]
            )
          ),
          Expanded(
            child: widget.body ?? Container(),
          )
        ]
      ),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
    );
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 500)).then((v) {loading = false;});
  }
}