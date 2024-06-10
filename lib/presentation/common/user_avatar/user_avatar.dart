import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/data/app/user_profile.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_provider.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends ConsumerStatefulWidget {

  const UserAvatar({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserAvatar();
}

class _UserAvatar  extends ConsumerState<UserAvatar> {  

  @override
  Widget build(BuildContext context) {    

    final state = ref.watch(userAvatarProvider);

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)]
        )
      ),
      width: MediaQuery.sizeOf(context).width,
      child: _build(state),
    );
  }

  Widget _build(UserAvatarState state) {

    if(state.isLoggedIn) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.6)
            ),
            width: 100.r,
            height: 100.r,
            child: Icon(
              Icons.person,
              size: 64.spMin,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 16.r),
          RichText(
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(                    
              children: <TextSpan>[
                TextSpan(
                  text: "Welcome ",                                                
                  style: const TextStyle().copyWith(
                    fontSize: 24.spMin,
                    color: Colors.black
                  )
                ),
                TextSpan(
                  text: UserProfile.name,
                  style: const TextStyle().copyWith(
                    fontSize: 24.spMin,
                    color: Colors.black,
                  )
                )
              ]
            )
          ),
          SizedBox(height: 16.r),
          _button(text: "Log Out", onTap: () async {
            final result = await ref.read(userAvatarProvider.notifier).logout();

            if(result) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("You have been logged out"),
                behavior: SnackBarBehavior.floating,                              
                dismissDirection: DismissDirection.horizontal,
                duration: Duration(seconds: 4)
              ));
            }
            
          })
        ],
      );
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.6)
            ),
            width: 100.r,
            height: 100.r,
            child: Icon(
              Icons.person,
              size: 64.spMin,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 16.r),
          Text(
            "Guest",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle().copyWith(
              fontSize: 24.spMin,
              color: Colors.black
            )
          ),
          SizedBox(height: 16.r),
          _button(text: "Log In", onTap: () {
            Navigator.pushNamed(context, RouteName.userHomeView);
          })
        ],
      );

  }

  GestureDetector _button({required String text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF01053d),
          borderRadius: BorderRadius.all(Radius.circular(32))
        ),
        padding: EdgeInsets.all(8.r),
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle().copyWith(
            fontSize: 16.r,
            color: const Color(0xFFcee6d8),
            fontWeight: FontWeight.w700
          )
        )
      )
    );
  }
}