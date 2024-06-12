import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/on_boarding_screen/components/on_boarding_screen_bottom_section/on_boarding_screen_botton_section_view.dart';
import 'package:flutter_demo/presentation/views/on_boarding_screen/on_boarding_screen_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreenView extends ConsumerStatefulWidget {

  const OnBoardingScreenView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingScreenView();
}

class _OnBoardingScreenView  extends ConsumerState<OnBoardingScreenView> {

  final PageController _pageController = PageController(initialPage: 0);
  final int totalPage = 3;

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlankPageWidget(       
      showBackBtn: false,         
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                if(index == (totalPage - 1)) {
                  ref.read(onBoardingScreenShowButtonProvider.notifier).state = true;
                }
              },
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // colors: [Color(0xFF005C97), Color(0xFF363795)]
                      colors: [Color(0xFF80D0C7), Color(0xFF0093E9)]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 30,
                              offset: const Offset(0, 0)
                            )
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xFF80D0C7), Color(0xFF0093E9)]
                          )
                        ),
                        padding: EdgeInsets.all(16.r),
                        child: Icon(
                          Icons.code,
                          size: 100.spMin,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 16.r),
                      Text(
                        "Flutter",
                        style: TextStyle(
                          fontSize: 24.spMin,
                          color: Colors.white
                        )
                      )
                    ]
                  )
                ),
                Container(
                  color: const Color(0xFFFAD961),                  
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(                        
                        Icons.phone_android,
                        size: 100.spMin,
                        color: Colors.black
                      ),
                      Text(
                        "There are many widgets you can test and play with it",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.spMin,
                          color: Colors.black
                        )
                      )
                    ]
                  )
                ),
                Container(
                  color: Colors.blue.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 100.spMin,
                        color: AppColor.primary                                                
                      )
                    ]
                  )
                )
              ]
            )
          ),
          OnBoardingScreenButtonSectionView(
            pageController: _pageController,
            totalPage: totalPage,
          )
        ],
      ),
    );
  }
}