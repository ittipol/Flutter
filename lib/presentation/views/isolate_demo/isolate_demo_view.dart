import 'package:flutter/material.dart';
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

class _IsolateDemoView  extends ConsumerState<IsolateDemoView> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  // late Animation<double> _heartbeatAnimation;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.repeat();
    });     

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(curve: Curves.fastOutSlowIn, parent: _controller));
    // _heartbeatAnimation = Tween(begin: 180.0, end: 120.0).animate(
    //   CurvedAnimation(
    //     curve: Curves.linear,
    //     parent: _controller
    //   ),
    // );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

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
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     const shakeCount = 10;
            //     const shakeOffset = 5.0;
            //     final sineValue = sin(shakeCount * 2 * pi * _controller.value);

            //     return Transform.translate(
            //       offset: Offset(sineValue * shakeOffset, 0),                  
            //       child:  Container(
            //         constraints: const BoxConstraints(
            //           minHeight: 120.0,
            //           maxHeight: 180.0
            //         ),
            //         child: Center(
            //           child: Icon(
            //             Icons.notifications_active,
            //             size: _heartbeatAnimation.value,
            //           ),
            //         ),
            //       )
            //     );
            //   },
            // ),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),              
              child: Icon(
                Icons.cached,
                size: 80.spMin,
              ),
            ),
            RotationTransition(
              turns: _animation,              
              child: Icon(
                Icons.cached,
                size: 80.spMin,
              ),
            ),
            SizedBox(height: 16.r),
            Text(
              "Fibonacci sequence = ${sequence.toString()}",
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
                  context.showLoaderOverlay();
                  ref.read(isolateDemoProvider.notifier).fibonacci(input: sequence);
                  context.hideLoaderOverlay();
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
            // GestureDetector(
            //   onTap: () async {                    
            //     _delayedTab(() async {                        
            //       context.showLoaderOverlay();
            //       await ref.read(isolateDemoProvider.notifier).isolateFibonacci(input: sequence);
            //       context.hideLoaderOverlay();
            //     });                      
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.greenAccent.shade200,
            //       borderRadius: const BorderRadius.all(Radius.circular(32))
            //     ),
            //     padding: EdgeInsets.all(8.r),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "With isolate",
            //       overflow: TextOverflow.ellipsis,
            //       style: const TextStyle().copyWith(
            //         fontSize: 16.r,
            //         color: Colors.black
            //       )
            //     )
            //   )
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                Expanded(
                  child: GestureDetector(
                    onTap: () async {                    
                      _delayedTab(() async {                        
                        context.showLoaderOverlay();
                        await ref.read(isolateDemoProvider.notifier).isolateFibonacci(input: sequence);
                        context.hideLoaderOverlay();
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
                        context.showLoaderOverlay();
                        await ref.read(isolateDemoProvider.notifier).simpleIsolateFibonacci(input: sequence);
                        context.hideLoaderOverlay();
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
            SizedBox(height: 32.r),
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