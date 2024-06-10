import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserLoginView extends ConsumerStatefulWidget {

  const UserLoginView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLoginView();
}

class _UserLoginView  extends ConsumerState<UserLoginView> {

  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {            
      
    });
  }

  @override
  void dispose(){
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final emailErrorText = ref.watch(userLoginEmailErrorTextProvider);

    return BlankPageWidget(
      showBackBtn: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        titleText: "LOGIN",
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            TextField(
              controller: _emailTextEditingController,
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                // color: AppColor.primary
              ),
              decoration: InputDecoration(
                // label: Text(
                //   "Email"
                // ),
                // border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
                hintText: "Email",
                hintStyle: const TextStyle().copyWith(
                  fontSize: 16.spMin,
                  // color: AppColor.primary
                ),
                errorText: emailErrorText
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                if (timer != null) {
                  timer?.cancel();
                }                

                timer = Timer(const Duration(milliseconds: 500), () async {
                  final result = Helper.isValidEmail(value);   
                  if(result) {
                    ref.read(userLoginEmailErrorTextProvider.notifier).state = null;
                  }else {
                    ref.read(userLoginEmailErrorTextProvider.notifier).state = "Email not valid";
                  }
                });
              }        
            ),
            SizedBox(height: 16.r),
            TextField(
              controller: _passwordTextEditingController,
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                // color: AppColor.primary
              ),
              decoration: InputDecoration(
                // label: Text(
                //   "Password"
                // ),
                // border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                hintText: "Password",
                hintStyle: const TextStyle().copyWith(
                  fontSize: 16.spMin,
                  // color: AppColor.primary
                ),
              ),
              autocorrect: false,
              obscureText: true,
              onChanged: (value) {
              
                
              }        
            ),
            SizedBox(height: 16.r),
            GestureDetector(
              onTap: () async {            

                if(_emailTextEditingController.text.isEmpty || _passwordTextEditingController.text.isEmpty) {
                  _dialog(context, "Please input email and password");
                  return;
                }

                if(!Helper.isValidEmail(_emailTextEditingController.text)) {
                  _dialog(context, "Please input valid email");
                  return;
                }                

                ref.showLoaderOverlay();

                final result = await ref.read(userLoginProvider.notifier).login(email: _emailTextEditingController.text, password: _passwordTextEditingController.text);

                if(result) {

                  final userProfile = await ref.read(userLoginProvider.notifier).profile();

                  if(userProfile) {
                    if(context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("You have been logged in"),
                        behavior: SnackBarBehavior.floating,                              
                        dismissDirection: DismissDirection.horizontal,
                        duration: Duration(seconds: 4)
                      ));
                      if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.home);
                    }                    
                  }                                    
                }else {
                  if(context.mounted) {
                    await ModalDialogWidget().showModalDialogWithOkButton(
                      context: context,
                      useInsetPadding: true,
                      body: Text(
                        "The email or password that you have entered does not match any account",
                        textAlign: TextAlign.center,
                        style: const TextStyle().copyWith(
                          fontSize: 16.spMin,
                          color: Colors.black
                        ),
                      ),
                      onTap: () {
                        if(Navigator.canPop(context)) Navigator.pop(context);
                      }
                    );
                  }
                }

                ref.hideLoaderOverlay();             
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(32))
                ),
                padding: EdgeInsets.all(8.r),
                alignment: Alignment.center,
                child: Text(
                  "Log In",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().copyWith(
                    fontSize: 16.r,
                    color: Colors.black
                  )
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  void _dialog(BuildContext context, String text) {
    ModalDialogWidget().showModalDialogWithOkButton(
      context: context,
      body: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle().copyWith(
          fontSize: 16.spMin,
          color: Colors.black
        ),
      ),
      onTap: () {
        if(Navigator.canPop(context)) Navigator.pop(context);
      }
    );
  }

}