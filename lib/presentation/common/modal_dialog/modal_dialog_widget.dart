import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalDialogWidget {

  Future<T?> showModalDialog<T>({
    required BuildContext context, 
    required Widget body, 
    double? width, 
    double? height, 
    bool useInsetPadding = false,
    bool useBorderRadius = true
  }) {
    return showDialog<T?>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: useInsetPadding ? EdgeInsets.symmetric(horizontal: 16.w) : EdgeInsets.zero,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: useBorderRadius ? const BorderRadius.all(Radius.circular(8)) : null
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              width: width,
              height: height,
              child: body,
            )
          )
        );
      }
    );
  }

  Future<T?> showModalDialogFullScreen<T>({
    required BuildContext context, 
    Widget? body, 
    bool showBackBtn = false
  }) {
    return showModalDialog(
      context: context,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      useBorderRadius: false,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: showBackBtn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,                    
                    child: GestureDetector(
                      onTap: () {                      
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 24.w,
                        height: 24.w,               
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h)
                ]
              )
            ),
            Expanded(
              child: body ?? Container(),
            )
          ],
        )
      )
    );
  }

  Future<T?> showFixedScreenModalDialog<T>({
    required BuildContext context, 
    Widget? body, 
    bool showBackBtn = false,
    required double width, 
    required double height,
    bool useBorderRadius = true
  }) {
    return showModalDialog(
      context: context,
      width: width,
      height: height,
      useBorderRadius: useBorderRadius,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: showBackBtn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,                    
                    child: GestureDetector(
                      onTap: () {                      
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 24.w,
                        height: 24.w,               
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h)
                ]
              )
            ),
            body ?? Container(),
          ],
        )
      )
    );
  }

  Future<T?> showModalDialogWithOkButton<T>({
    required BuildContext context, 
    required String title, 
    Widget? body,
    void Function()? onTap, 
    bool fullScreenWidth = false,
    bool useInsetPadding = false
  }) {
    return showModalDialog(
      context: context,
      width: fullScreenWidth ? MediaQuery.sizeOf(context).width : null,
      useInsetPadding: useInsetPadding,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black
              ),
            ),
            Visibility(
              visible: body != null,
              child: body ?? Container(),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,                            
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue.shade600),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: Colors.blue.shade600
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Future<T?> showModalDialogWithOkCancelButton<T>({
    required BuildContext context, 
    required String title,
    Widget? body,
    void Function()? onTapOk,
    void Function()? onTapCancel,
    bool fullScreenWidth = false,
    bool useInsetPadding = false
  }) {
    return showModalDialog(
      context: context,
      width: fullScreenWidth ? MediaQuery.sizeOf(context).width : null,
      useInsetPadding: useInsetPadding,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black
              ),
            ),
            Visibility(
              visible: body != null,
              child: body ?? Container(),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onTapCancel,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: Colors.white
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onTapOk,
                    child: Container(
                      alignment: Alignment.center,                            
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blue.shade600),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: Colors.blue.shade600
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

}