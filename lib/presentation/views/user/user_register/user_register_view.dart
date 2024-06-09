import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/user/user_register/user_register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRegisterView extends ConsumerStatefulWidget {

  const UserRegisterView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserRegisterView();
}

class _UserRegisterView  extends ConsumerState<UserRegisterView> {

  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _nameTextEditingController = TextEditingController();
  Timer? timer;

  @override
  void dispose(){
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _nameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final emailErrorText = ref.watch(userRegisterEmailErrorTextProvider);

    return BlankPageWidget(
      showBackBtn: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        titleText: "REGISTER",
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
                hintText: "Email",
                hintStyle: const TextStyle().copyWith(
                  fontSize: 16.spMin,
                  // color: AppColor.primary
                ),
                // errorText: "Email not valid"
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
                    ref.read(userRegisterEmailErrorTextProvider.notifier).state = null;
                  }else {
                    ref.read(userRegisterEmailErrorTextProvider.notifier).state = "Email not valid";
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
            TextField(
              controller: _nameTextEditingController,
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                // color: AppColor.primary
              ),
              decoration: InputDecoration(
                // label: Text(
                //   "Password"
                // ),
                // border: OutlineInputBorder(),
                hintText: "Name",
                hintStyle: const TextStyle().copyWith(
                  fontSize: 16.spMin,
                  // color: AppColor.primary
                ),
              ),
              onChanged: (value) {
                
              }        
            ),
            SizedBox(height: 16.r),
            GestureDetector(
              onTap: () async {

                if(!Helper.isValidEmail(_emailTextEditingController.text) || _emailTextEditingController.text.isEmpty || _passwordTextEditingController.text.isEmpty || _nameTextEditingController.text.isEmpty) {

                  ModalDialogWidget().showModalDialogWithOkButton(
                    context: context,
                    body: Text(
                      "Please input Email, Password and Name",
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

                  return;
                }

                ref.showLoaderOverlay();
                // await ref.read(userRegisterProvider.notifier).register(email: "test@email.com", password: "1234");
                final result = await ref.read(userRegisterProvider.notifier).register(
                  email: _emailTextEditingController.text, 
                  password: _passwordTextEditingController.text,
                  name: _nameTextEditingController.text
                );

                if(result.isCompleted) {
                  await ModalDialogWidget().showModalDialogWithOkButton(
                    context: context,
                    useInsetPadding: true,
                    body: Text(
                      "Register succeeded",
                      textAlign: TextAlign.center,
                      style: const TextStyle().copyWith(
                        fontSize: 16.spMin,
                        color: Colors.black
                      ),
                    ),
                    onTap: () {
                      if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.userHomeView);
                    }
                  );
                }else {
                  await ModalDialogWidget().showModalDialogWithOkButton(
                    context: context,
                    useInsetPadding: true,
                    body: Text(
                      "Register not succeed",
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
                  "Register",
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