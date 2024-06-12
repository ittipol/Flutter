import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/domain/entities/menu_entity.dart';
import 'package:flutter_demo/enum/modal_dialog_content_type.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_content.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/user/user_home/user_home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHomeView extends ConsumerStatefulWidget {

  const UserHomeView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeView();
}

class _UserHomeView  extends ConsumerState<UserHomeView> {

  final apiHealthCheck = "${ApiBaseUrl.localhostApiBaseUrl}/health";
  final menuList = [
    MenuEntity(title: "Log In", link: RouteName.userLoginView, icon: Icons.login),
    MenuEntity(title: "Register", link: RouteName.userRegisterView, icon: Icons.person_add),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async { 

      final value = await Helper.checkUrlActive(apiHealthCheck);

      if(!value) {
        ModalDialogContent.show(context: context, type: ModalDialogContentType.howToStartServer);       
      }      

      ref.read(userHomeIsActiveUrlProvider.notifier).state = value;      
    });
  }

  @override
  Widget build(BuildContext context) {

    final isActiveServer = ref.watch(userHomeIsActiveUrlProvider);
    final state = ref.watch(userHomeProvider);

    return BlankPageWidget(
      showBackBtn: false,
      appBar: AppBarWidget(
        titleText: "AUTHENTICATION",
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.grey.shade100
                ),
                child: Column(
                  children: [
                    Text(
                      "Please start a server before authentication",
                      textAlign: TextAlign.center,
                      style: const TextStyle().copyWith(
                        fontSize: 16.spMin,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: 8.r),
                    const Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),
                    SizedBox(height: 8.r),
                    GestureDetector(
                      onTap: () {
                        ModalDialogContent.show(context: context, type: ModalDialogContentType.howToStartServer);
                      },
                      child: Text(
                        "How to start a server?",
                        textAlign: TextAlign.center,
                        style: const TextStyle().copyWith(
                          fontSize: 16.spMin,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    SizedBox(height: 8.r),
                    GestureDetector(
                      onTap: () {
                        ModalDialogContent.show(context: context, type: ModalDialogContentType.androidSetProxyAddress);
                      },
                      child: Text(
                        "How to set the Android Emulator proxy address?",
                        textAlign: TextAlign.center,
                        style: const TextStyle().copyWith(
                          fontSize: 16.spMin,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    SizedBox(height: 16.r),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isActiveServer == null ? Colors.grey.shade200 : isActiveServer == true ? Colors.green : Colors.red,
                        borderRadius: const BorderRadius.all(Radius.circular(16))
                      ),
                      child: Text(
                        "Server: ${isActiveServer == null ? "-" : isActiveServer == true ? "Active" : "Not Active"}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.spMin
                        )
                      )
                    )
                  ]
                )
              ),
              SizedBox(height: 16.r),              
              Visibility(
                visible: state.isLoggedIn,
                child: GestureDetector(
                  onTap: () {
                    ref.read(userHomeProvider.notifier).logout();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.r),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 5,
                          offset: const Offset(3, 3)
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,              
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "Log Out",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.spMin,
                              color: Colors.black
                            )
                          )
                        )
                      ]
                    )
                  )
                ),
              ),
              Visibility(
                visible: !state.isLoggedIn,
                child: GridView.builder(        
                  itemCount: menuList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16/9, // Horizontal/Vertical
                    mainAxisSpacing: 8.r,
                    crossAxisSpacing: 8.r,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var menu = menuList[index];
      
                    return GestureDetector(
                      onTap: () async {
      
                        final value = await Helper.checkUrlActive(apiHealthCheck);
                        ref.read(userHomeIsActiveUrlProvider.notifier).state = value;
      
                        if(value) {
      
                          if(context.mounted) {
                            await Navigator.pushNamed(context, menu.link);
      
                            if(Authentication.isLoggedIn) {
                              ref.read(userHomeProvider.notifier).update(isLoggedIn: Authentication.isLoggedIn);
                            }
                          }                                                        
                                  
                        }else {                        
                          
                          ModalDialogWidget().showModalDialogWithOkButton(
                            context: context,
                            body: Text(
                              "Please start a server",
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
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              blurRadius: 5,
                              offset: const Offset(3, 3)
                            )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,              
                          children: [
                            const Spacer(),
                            Icon(
                              menu.icon ?? Icons.phone_android,
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.r),
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                menu.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: Colors.black
                                ),
                              )
                            ),
                            const Spacer(),
                          ]
                        )
                      )
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }  
}