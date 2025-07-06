import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/platform_channel/platform_channel_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformChannelView extends ConsumerStatefulWidget {

  const PlatformChannelView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlatformChannelView();
}

class _PlatformChannelView  extends ConsumerState<PlatformChannelView> {  

  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getBatteryLevel();
    });    
  }

  @override
  Widget build(BuildContext context) {    

    final batteryLevel = ref.watch(batteryLevelProvider);

    return BlankPageWidget(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: Text(
            batteryLevel,
            style: const TextStyle().copyWith(
              fontSize: 24.spMin,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'";
    } on MissingPluginException catch (e) {
      debugPrint("Error: ${e.message}");
      batteryLevel = "Error: No implementation found";
    }

    ref.read(batteryLevelProvider.notifier).state = batteryLevel;
  }

}