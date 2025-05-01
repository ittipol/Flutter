import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselView extends ConsumerStatefulWidget {

  const CarouselView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarouselView();
}

class _CarouselView  extends ConsumerState<CarouselView> {  

  @override
  Widget build(BuildContext context) {

    return BlankPageWidget(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.grey.shade700
            ),
            width: MediaQuery.sizeOf(context).width,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 100.r,
                // enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                // aspectRatio: 16 / 9,
                autoPlayCurve: Curves.linear,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 1,
                // onPageChanged:(index, reason) {
                //   debugPrint(index.toString());
                // },
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        ModalDialogWidget.showModalDialogWithOkButton(
                          context: context,
                          title: "Title $i clicked",
                          onTap: () {
                            ModalDialogWidget.closeModalDialog(context: context);
                          }
                        );
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        // margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          // color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)
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
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24.r,),
          Container(
            // padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)]
              )
            ),
            width: MediaQuery.sizeOf(context).width,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 100.r,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                // aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeOutQuint,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 1
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      // margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                      ),
                      child: Center(
                        child: Text(
                          "Title $i",
                          style: TextStyle(
                            fontSize: 24.spMin,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black
                          )
                        ),
                      )
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24.r,),
          Container(
            // padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.grey.shade800
            ),
            width: MediaQuery.sizeOf(context).width,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 100.r,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                // aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeOutQuint,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 1
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint("Title $i");
                        Navigator.pushNamed(context, RouteName.uiDemoView);
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        // margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.r),
                              child: Text(
                                "Title $i abcdefghijklmnopqurstwxyz",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.spMin,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white
                                )
                              ),
                            ),
                            SizedBox(height: 8.r,),
                            Text(
                              "See more >",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.spMin,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.yellow.shade700
                              )
                            ),
                          ],
                        )
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      )
    );
    
  }

}