import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
          SizedBox(height: 24.r,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteName.uiDemoView);
            },
            child: Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 12.r),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width * 0.29,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xFFEBEFF2), Color(0xFFFFFFFF)],
                  stops: [0.40, 0.65]
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade700
                    ),
                  ),
                  SizedBox(
                    width: 220.r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(         
                          width: MediaQuery.sizeOf(context).width,
                          // decoration: BoxDecoration(
                          //   color: Colors.grey.shade700
                          // ),
                          child: Text(
                            "title",
                            style: const TextStyle().copyWith(
                              fontSize: 14.spMin,
                              color: const Color(0xFF3A3433),
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(                        
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              // decoration: BoxDecoration(
                              //   color: Colors.grey.shade700
                              // ),
                              child: Text(
                                "subtitle",
                                style: const TextStyle().copyWith(
                                  fontSize: 12.spMin,
                                  color: const Color(0xFF3A3433),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: 96.r,
                              height: 24.r,
                              // padding: EdgeInsets.symmetric(vertical: 4.r),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade700,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Center(
                                child: Text(
                                    "ตกลง",
                                    style: const TextStyle().copyWith(
                                      fontSize: 14.spMin,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
    
  }

}