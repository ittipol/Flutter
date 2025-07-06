import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/responsive_layout/responsive_layout.dart';
import 'package:flutter_demo/presentation/common/responsive_layout_builder/responsive_layout_builder.dart';
import 'package:flutter_demo/helper/app_screen_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveDesignView extends ConsumerStatefulWidget {

  const ResponsiveDesignView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponsiveDesignView();
}

class _ResponsiveDesignView  extends ConsumerState<ResponsiveDesignView> {  

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 2), () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      });
    });    
  }

  @override
  dispose(){    
    if(AppScreenHelper.isMobile) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {    

    // var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    // var screenHeight = screenSize.height;
    // var clientHeight = screenHeight - kToolbarHeight;
    
    return BlankPageWidget(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(bottom: 24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.secondary
                )
              )
            ),
            child: Text(
              "Responsive Design",
              style: TextStyle(
                fontSize: 24.spMin
              )
            ),
          ),
          ResponsiveLayoutBuilder(
            mobilePortrait: (ctx) {
              debugPrint("====> mobilePortrait ${MediaQuery.sizeOf(context).width}");
              return Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "Mobile Portrait",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.spMin
                  )
                )
              );
            },
            mobileLandscape: (ctx) {
              debugPrint("====> mobileLandscape ${MediaQuery.sizeOf(context).width}");
              return Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: const BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "Mobile Landscape",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.spMin
                  )
                )
              );
            },
            tabletPortrait: (ctx) {
              debugPrint("tabletPortrait ${MediaQuery.sizeOf(context).width}");
              return Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: const BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "Tablet Portrait",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.spMin
                  )
                )
              );
            },
            tabletLandscape: (ctx) {
              debugPrint("tabletLandscape ${MediaQuery.sizeOf(context).width}");
              return Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "Tablet Landscape",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.spMin
                  )
                )
              );
            },
            webAppAll: (ctx) {
              return Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.shade700,
                  borderRadius: const BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "Website",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.spMin
                  )
                )
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [                  
                  ResponsiveLayoutBuilder(
                    mobileAll: (ctx) {
                      return Text(
                        "Rotate your device",
                        style: TextStyle(
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w700
                        ),
                      );
                    },
                    tabletAll: (ctx) {
                      return Text(
                        "Rotate your device",
                        style: TextStyle(
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w700
                        ),
                      );
                    },
                    webAppAll: (ctx) {
                      return Text(
                        "Resize your screen",
                        style: TextStyle(
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w700
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ResponsiveLayoutBuilder(
                    mobilePortrait: (ctx) {
                      return _grid(itemCount: 20, crossAxisCount: 2, childAspectRatio: 9/16);
                    },
                    mobileLandscape: (ctx) {
                      return _grid(itemCount: 24,crossAxisCount: 3, childAspectRatio: 16/9);
                    },
                    tabletPortrait: (ctx) {
                      return _grid(itemCount: 20, crossAxisCount: 2, childAspectRatio: 9/16);
                    },
                    tabletLandscape: (ctx) {
                      return _grid(itemCount: 24,crossAxisCount: 3, childAspectRatio: 16/9);
                    },
                    webAppAll: (ctx) {
                      return ResponsiveLayout(
                        desktop: (ctx) {
                          return _desktopContainer(
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            color: Colors.green.shade100
                          );
                        },
                        tablet: (ctx) {
                          return _desktopContainer(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            color: Colors.orange.shade100
                          );
                        },
                        mobile: (ctx) {
                          return _desktopContainer(
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.blue.shade100
                          );
                        }
                      );
                    }
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  Widget _desktopContainer({required double? width, required Color color}) {
    return Container(
      width: width,
      height: 300.r,
      color: color
    );
  }

  GridView _grid({int? itemCount, required int crossAxisCount, required double childAspectRatio}) {
    return GridView.builder(        
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio, // 16/9 = Horizontal/Vertical
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: Colors.teal[100 * (index % 9)],
          child: Text(
            'Grid item $index',
            style: TextStyle(
              fontSize: 16.spMin
            )
          )
        );
      }
    );
  }
}