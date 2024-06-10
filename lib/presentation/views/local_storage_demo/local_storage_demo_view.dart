import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/local_storage_demo/local_storage_demo_provider.dart';
import 'package:flutter_demo/helper/app_screen_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalStorageDemoView extends ConsumerStatefulWidget {

  const LocalStorageDemoView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocalStorageDemoView();
}

class _LocalStorageDemoView  extends ConsumerState<LocalStorageDemoView> {

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.showLoaderOverlay();
      await ref.read(localStorageDemoProvider.notifier).getData();
      await Future.delayed(const Duration(seconds: 1), () {
        ref.hideLoaderOverlay();
      });
    });     
  }

  @override
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   

    final state = ref.watch(localStorageDemoProvider);

    return BlankPageWidget(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stored text",
              style: TextStyle(
                fontSize: 24.spMin,
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 200
              ),
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),              
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(4))
              ),
              child: SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Text(
                  (state.name == null || state.name == "") ? "No stored text" : state.name ?? "",
                  style: TextStyle(
                    fontSize: 16.spMin,
                    color: (state.name == null || state.name == "") ? Colors.red : Colors.black
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ModalDialogWidget().showModalDialogWithOkCancelButton(
                        context: context,
                        title: "Delete stored text?",
                        onTapCancel: () {
                          if(Navigator.canPop(context)) Navigator.pop(context);
                        },
                        onTapOk: () async {
                          if(Navigator.canPop(context)) Navigator.pop(context);
                          ref.showLoaderOverlay();
                          await ref.read(localStorageDemoProvider.notifier).deleteData();
                          await Future.delayed(const Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Stored text deleted"),
                              behavior: SnackBarBehavior.floating,                              
                              dismissDirection: DismissDirection.horizontal,
                              duration: Duration(seconds: 4)
                            ));
                            ref.hideLoaderOverlay();
                          });
                        },
                        useInsetPadding: true,
                        fullScreenWidth: AppScreenHelper.isDesktop ? false : true
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: Colors.red.shade500
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text(
                        "Delete",
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
                    onTap: () {
                      ModalDialogWidget().showModalDialogWithOkCancelButton(
                        context: context,
                        title: "Insert stored text",
                        body: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: _textController,
                        ),
                        onTapCancel: () {
                          if(Navigator.canPop(context)) Navigator.pop(context);
                          _textController.text = "";
                        },
                        onTapOk: () async {
                          if(Navigator.canPop(context)) Navigator.pop(context);

                          if(_textController.text.isEmpty) {

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("No input text"),
                              behavior: SnackBarBehavior.floating,                              
                              dismissDirection: DismissDirection.horizontal,
                              duration: Duration(seconds: 4)
                            ));

                          }else {
                            ref.showLoaderOverlay();
                            await ref.read(localStorageDemoProvider.notifier).saveData(_textController.text);
                            await Future.delayed(const Duration(seconds: 1), () {
                              _textController.text = "";
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Stored text saved"),
                                behavior: SnackBarBehavior.floating,                              
                                dismissDirection: DismissDirection.horizontal,
                                duration: Duration(seconds: 4)
                              ));
                              ref.hideLoaderOverlay();
                            });
                          }                          
                        },
                        useInsetPadding: true,
                        fullScreenWidth: AppScreenHelper.isDesktop ? false : true
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,                            
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: Colors.green.shade500
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text(
                        "Insert",
                        style: TextStyle(
                          color: Colors.black
                        )
                      )
                    )
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}