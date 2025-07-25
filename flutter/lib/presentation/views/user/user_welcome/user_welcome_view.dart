import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserWelcomeView extends ConsumerStatefulWidget {

  const UserWelcomeView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserWelcomeView();
}

class _UserWelcomeView  extends ConsumerState<UserWelcomeView> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      context.showLoaderOverlay();

      await Future.delayed(const Duration(seconds: 3), () {
        context.hideLoaderOverlay();
      });
    });

    super.initState();    
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   

    return const BlankPageWidget(
      showBackBtn: false,
      body: UserAvatar(),
    );
  }
}