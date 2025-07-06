import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends AppBar {

  final String titleText;
  final bool showBackButton;
  final void Function()? backButtonOnPressed;

  AppBarWidget({
    required this.titleText,
    this.showBackButton = true,
    this.backButtonOnPressed,
    super.actions,
    super.key
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidget();
  // State<AppBar> createState() => _AppBarState();
}

class _AppBarWidget  extends State<AppBarWidget> {  
// class _AppBarState extends State<AppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.titleText,
        style: const TextStyle().copyWith(fontSize: 16.spMin),
      ),
      centerTitle: true,
      elevation: 8,
      shadowColor: Colors.black,      
      actions: widget.actions,
      leading: Visibility(
        visible: widget.showBackButton,
        child: BackButton(
          onPressed: widget.backButtonOnPressed ?? () {
            if(Navigator.canPop(context)) Navigator.pop(context);
          }
        ),
      )
    );
  }
}