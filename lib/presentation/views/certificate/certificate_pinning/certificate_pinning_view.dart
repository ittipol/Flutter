import 'package:flutter/material.dart';
import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertificatePinningView extends ConsumerStatefulWidget {

  const CertificatePinningView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CertificatePinningView();
}

class _CertificatePinningView  extends ConsumerState<CertificatePinningView> {

  bool loading = false;
  final server1 = "${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5050}";
  final server2 = "${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5051}";
  
  @override
  Widget build(BuildContext context) {

    final isCert1Allowed = ref.watch(certificatePinningProvider.select((value) => value.isCert1Allowed));
    final isCert2Allowed = ref.watch(certificatePinningProvider.select((value) => value.isCert2Allowed));

    return BlankPageWidget(
      showBackBtn: false,
      appBar: AppBarWidget(
        titleText: "CERTIFICATE PINNING",
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "SHA256Fingerprint: ${CertificateHelper.getCertFingerPrint(Certificate.certificate)}",
            //   style: const TextStyle().copyWith(
            //     fontSize: 16.spMin,
            //     fontWeight: FontWeight.w700
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isCert1Allowed,
                  onChanged: (bool? value) {
                    ref.read(certificatePinningProvider.notifier).checkCert1(value ?? false);
                  },
                ),
                Text(
                  "Allow connection to $server1",
                  style: TextStyle(
                    fontSize: 14.spMin
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isCert2Allowed,
                  onChanged: (bool? value) {
                    ref.read(certificatePinningProvider.notifier).checkCert2(value ?? false);
                  },
                ),
                Text(
                  "Allow connection to $server2",
                  style: TextStyle(
                    fontSize: 14.spMin
                  )
                )
              ],
            ),
            Divider(height: 32.r),
            GestureDetector(
              onTap: () async {                      
                _delayedTab(() async {                        
                  context.showLoaderOverlay();                  
                  var response = await ref.read(certificatePinningProvider.notifier).connectToServer1();
                  context.hideLoaderOverlay();

                  ModalDialogWidget.showModalDialogWithOkButton(
                    context: context,
                    body: Text(
                      "$server1 => Response: $response",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.black
                      )
                    ),
                    onTap: () {
                      ModalDialogWidget.closeModalDialog(context: context);
                    },
                    useInsetPadding: true,
                    fullScreenWidth: true
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Connect to $server1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  )
                ),
              ),
            ),
            SizedBox(height: 16.r),
            GestureDetector(
              onTap: () async {                      
                _delayedTab(() async {                        
                  context.showLoaderOverlay();                  
                  var response = await ref.read(certificatePinningProvider.notifier).connectToServer2();
                  context.hideLoaderOverlay();

                  ModalDialogWidget.showModalDialogWithOkButton(
                    context: context,
                    body: Text(
                      "$server2 => Response: $response",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.black
                      )
                    ),
                    onTap: () {
                      ModalDialogWidget.closeModalDialog(context: context);
                    },
                    useInsetPadding: true,
                    fullScreenWidth: true
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Connect to $server2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 500)).then((v) {loading = false;});
  }
}