import 'package:flutter/material.dart';
import 'package:flutter_demo/data/app/user_profile.dart';
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
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        // color: Colors.grey.shade100
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)]
        )
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(width: 2, color: Colors.amber),
              color: Colors.white.withOpacity(0.6)
            ),
            width: 100.r,
            height: 100.r,
            child: Icon(
              Icons.person,
              size: 64.spMin,
              // color: Color(0xFFffe66b),
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
                    fontWeight: FontWeight.w700
                  )
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}