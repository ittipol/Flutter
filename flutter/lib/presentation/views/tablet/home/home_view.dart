import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabletHomeView extends ConsumerStatefulWidget {

  const TabletHomeView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabletHomeView();
}

class _TabletHomeView  extends ConsumerState<TabletHomeView> {

  @override
  Widget build(BuildContext context) {
    return BlankPageWidget(
      showBackBtn: false,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            "Tablet Home",
            style: TextStyle(
              fontSize: 32.spMin,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}