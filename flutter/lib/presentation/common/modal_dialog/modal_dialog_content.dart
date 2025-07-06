import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/enum/modal_dialog_content_type.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalDialogContent {

  static void show({required BuildContext context, required ModalDialogContentType type}) {

    switch (type) {
      case ModalDialogContentType.howToStartServer:
          _howToStartServer(context: context);
        break;
      case ModalDialogContentType.androidSetProxyAddress:
          _androidSetProxyAddress(context: context);
        break;
      default:
    }

  }

  static void _howToStartServer({required BuildContext context}) {
    ModalDialogWidget.showModalDialogWithOkButton(
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
                  recognizer: TapGestureRecognizer()..onTap = () {}
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
        ModalDialogWidget.closeModalDialog(context: context);
      }
    );
  }

  static void _androidSetProxyAddress({required BuildContext context}) {
    ModalDialogWidget.showModalDialogWithOkButton(
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
        ModalDialogWidget.closeModalDialog(context: context);
      }
    );
  }

}