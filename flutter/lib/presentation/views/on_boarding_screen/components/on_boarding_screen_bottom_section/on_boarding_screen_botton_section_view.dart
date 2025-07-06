import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/on_boarding_screen/on_boarding_screen_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreenButtonSectionView extends ConsumerStatefulWidget {

  final PageController pageController;
  final int totalPage;

  const OnBoardingScreenButtonSectionView({
    required this.pageController,
    required this.totalPage,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingScreenButtonSectionView();
}

class _OnBoardingScreenButtonSectionView  extends ConsumerState<OnBoardingScreenButtonSectionView> {

  

  @override
  Widget build(BuildContext context) {

    final showButton = ref.watch(onBoardingScreenShowButtonProvider);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 80.r,
      child: _build(showButton),
    );

  }

  Widget _build(bool showButton) {

    if(showButton) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.zero
            ),
          ),
        ),
        child: SizedBox(
          child: Center(
            child: Text(
              "Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.spMin,
                fontWeight: FontWeight.w700,
              )
            ),
          )
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('show_on_boarding_screen', false);
          Navigator.pushReplacementNamed(context, RouteName.home);
        },
      );
    }else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              widget.pageController.animateToPage(widget.totalPage - 1, duration: const Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
            },
            child: const Text(
              "SKIP",
              style: TextStyle(
                color: AppColor.primary
              )
            )
          ),
          Center(
            child: SmoothPageIndicator(
              controller: widget.pageController,
              count: widget.totalPage,
              effect: ExpandingDotsEffect(
                dotHeight: 16,
                dotWidth: 16,
                dotColor: Colors.grey.shade200,
                activeDotColor: AppColor.primary
              ),
              // onDotClicked: (index) {
              //   widget.pageController.animateToPage(index, duration: const Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
              // },
            ),
          ),
          TextButton(
            onPressed: () {
              widget.pageController.nextPage(duration: const Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
            }, 
            child: const Text(
              "NEXT",
              style: TextStyle(
                color: AppColor.primary
              )
            )
          )
        ],
      );
    }

  }

}