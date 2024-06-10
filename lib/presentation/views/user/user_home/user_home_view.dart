import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/domain/entities/menu_entity.dart';
import 'package:flutter_demo/helper/api_base_url_helper.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
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

  List<MenuEntity> menuList = [
    MenuEntity(title: "Log In", link: RouteName.userLoginView, icon: Icons.login),
    MenuEntity(title: "Register", link: RouteName.userRegisterView, icon: Icons.person_add),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async { 

      final value = await Helper.checkUrlActive(ApiBaseUrlHelper.getLocalhostBaseUrl(includePort: false));

      if(!value) {
        _hint1();
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
              // const UserAvatar(),
              // SizedBox(height: 16.r),
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
                        _hint1();
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
                        _hint2();
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
      
                        final value = await Helper.checkUrlActive(ApiBaseUrlHelper.getLocalhostBaseUrl(includePort: false));
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

  void _hint1() {
    ModalDialogWidget().showModalDialogWithOkButton(
      context: context,
      useInsetPadding: true,
      title: "How to start a server?",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. If you do not installed a Docker. you have to download and install",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            ),
          ),
          Text(
            "2. Go to api folder",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            ),
          ),
          RichText(
            text: TextSpan(
              text: "3. Run",
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                color: Colors.black
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: " `",
                ),
                TextSpan(
                  text: "docker compose up -d --build",
                  style: const TextStyle().copyWith(
                    fontSize: 16.spMin,
                    color: Colors.green,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const TextSpan(
                  text: "` ",
                ),
                TextSpan(
                  text: "to start a server",
                  style: const TextStyle().copyWith(
                    fontSize: 16.spMin,
                    color: Colors.black
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    // Navigator.pushNamed(context, menu.link);
                  }
                )
              ]
            )
          ),
          SizedBox(height: 16.r),
          Text(
            "* If you are running on Android Emulator, Please set the proxy address to 10.0.2.2",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          )
        ],
      ),
      onTap: () {
        if(Navigator.canPop(context)) Navigator.pop(context);
      }
    );
  }

  void _hint2() {
    ModalDialogWidget().showModalDialogWithOkButton(
      context: context,
      useInsetPadding: true,
      title: "How to set the Android Emulator proxy address?",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. Click horizontal ellipsis … (Three dot icon)",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "2. Click settings",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "3. Click proxy tab",            
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "4. Select Manual proxy configuration",
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "5. Input 10.0.2.2 in Host name",
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "6. Input 80 in Port number",
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          ),
          Text(
            "7. Click apply",
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            )
          )          
        ],
      ),
      onTap: () {
        if(Navigator.canPop(context)) Navigator.pop(context);
      }
    );
  }
}