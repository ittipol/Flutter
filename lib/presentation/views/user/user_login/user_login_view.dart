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

                // if(!Helper.isValidEmail(_emailTextEditingController.text) || _emailTextEditingController.text.isEmpty || _passwordTextEditingController.text.isEmpty) {

                //   ModalDialogWidget().showModalDialogWithOkButton(
                //     context: context,
                //     body: Text(
                //       "Please input Email and Password",
                //       textAlign: TextAlign.center,
                //       style: const TextStyle().copyWith(
                //         fontSize: 16.spMin,
                //         color: Colors.black
                //       ),
                //     ),
                //     onTap: () {
                //       if(Navigator.canPop(context)) Navigator.pop(context);
                //     }
                //   );

                //   return;
                // }

                ref.showLoaderOverlay();
                var result = await ref.read(userLoginProvider.notifier).login(email: "test@email.com", password: "1234");
                // var result = await ref.read(userLoginProvider.notifier).login(email: "test", password: "1234");
                // final result = await ref.read(userLoginProvider.notifier).login(email: _emailTextEditingController.text, password: _passwordTextEditingController.text);

                if(result.isCompleted) {

                  final userProfile = await ref.read(userLoginProvider.notifier).profile();

                  if(userProfile.isCompleted) {                    
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Login succeeded"),
                      behavior: SnackBarBehavior.floating,                              
                      dismissDirection: DismissDirection.horizontal,
                      duration: Duration(seconds: 4)
                    ));
                    if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.userHomeView);
                  }                  

                  // await ModalDialogWidget().showModalDialogWithOkButton(
                  //   context: context,
                  //   useInsetPadding: true,
                  //   body: Text(
                  //     "Login succeeded",
                  //     textAlign: TextAlign.center,
                  //     style: const TextStyle().copyWith(
                  //       fontSize: 16.spMin,
                  //       color: Colors.black
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.userHomeView);
                  //   }
                  // );
                }else {
                  await ModalDialogWidget().showModalDialogWithOkButton(
                    context: context,
                    useInsetPadding: true,
                    body: Text(
                      "Login not succeed",
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
                  "Login",
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

}