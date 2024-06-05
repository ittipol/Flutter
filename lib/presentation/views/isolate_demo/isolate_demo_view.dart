import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/isolate_demo/isolate_demo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsolateDemoView extends ConsumerStatefulWidget {

  const IsolateDemoView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IsolateDemoView();
}

class _IsolateDemoView  extends ConsumerState<IsolateDemoView> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final result = ref.watch(isolateDemoProvider);
    const sequence = 40;

    return BlankPageWidget(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Container(
              padding: EdgeInsets.all(16.r),
              child: Transform.scale(
                scale: 2, 
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColor.primary
                )
              ),
            ),
            SizedBox(height: 16.r),
            Text(
              "fibonacci sequence = ${sequence.toString()}",
              style: const TextStyle().copyWith(
                fontSize: 16.r
              )
            ),
            SizedBox(height: 16.r),
            Text(
              "Result: ${result.toString()}",
              style: const TextStyle().copyWith(
                fontSize: 24.r
              )
            ),
            SizedBox(height: 16.r),
            GestureDetector(
              onTap: () {
                _delayedTab(() {
                  ref.showLoaderOverlay();
                  ref.read(isolateDemoProvider.notifier).fibonacci(input: sequence);
                  ref.hideLoaderOverlay();
                });                      
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(32))
                ),
                padding: EdgeInsets.all(8.r),
                alignment: Alignment.center,
                child: Text(
                  "Without isolate",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().copyWith(
                    fontSize: 16.r,
                    color: Colors.black
                  )
                ),
              ),
            ),
            SizedBox(height: 16.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                Expanded(
                  child: GestureDetector(
                    onTap: () async {                    
                      _delayedTab(() async {                        
                        ref.showLoaderOverlay();
                        await ref.read(isolateDemoProvider.notifier).isolateFibonacci(input: sequence);
                        ref.hideLoaderOverlay();
                      });                      
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade200,
                        borderRadius: const BorderRadius.all(Radius.circular(32))
                      ),
                      padding: EdgeInsets.all(8.r),
                      alignment: Alignment.center,
                      child: Text(
                        "With isolate #1",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().copyWith(
                          fontSize: 16.r,
                          color: Colors.black
                        )
                      )
                    )
                  )
                ),
                SizedBox(width: 16.r),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {                    
                      _delayedTab(() async {                        
                        ref.showLoaderOverlay();
                        await ref.read(isolateDemoProvider.notifier).simpleIsolateFibonacci(input: sequence);
                        ref.hideLoaderOverlay();
                      });                      
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade200,
                        borderRadius: const BorderRadius.all(Radius.circular(32))
                      ),
                      padding: EdgeInsets.all(8.r),
                      alignment: Alignment.center,
                      child: Text(
                        "With isolate #2",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().copyWith(
                          fontSize: 16.r,
                          color: Colors.black
                        )
                      )
                    )
                  )
                )
              ],
            ),
            SizedBox(height: 16.r),
            GestureDetector(
              onTap: () async {
                ref.read(isolateDemoProvider.notifier).update(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(32))
                ),
                padding: EdgeInsets.all(8.r),
                alignment: Alignment.center,
                child: Text(
                  "Clear",
                  style: const TextStyle().copyWith(
                    fontSize: 16.r,
                    color: Colors.black
                  )
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            )
          ]
        )
      )
    );
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 500)).then((v) {loading = false;});
  }
}