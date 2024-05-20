import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalDialogWidget {

  Future<T?> showModalDialog<T>({required BuildContext context, required Widget body}) {
    return showDialog<T?>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),         
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: body,
        )
      ),
    );
  }

  Future<T?> showModalDialogWithOkButton<T>({required BuildContext context, required String title, void Function()? onTap}) {
    return showModalDialog(
      context: context,
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
                fontSize: 16.sp
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,                            
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue.shade600),
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
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
        ),
      )
    );
  }

  Future<T?> showModalDialogWithOkCancelButton<T>({
    required BuildContext context, 
    required String title, 
    void Function()? onTapOk,
    void Function()? onTapCancel,
  }) {
    return showModalDialog(
      context: context,
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
                fontSize: 16.sp
              ),
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
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        color: Colors.white
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white
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
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
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