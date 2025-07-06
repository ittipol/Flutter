import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrientationLayout extends ConsumerStatefulWidget {

  final Widget Function(BuildContext)? all;
  final Widget Function(BuildContext)? portrait;
  final Widget Function(BuildContext)? landscape;

  const OrientationLayout({
    this.all,
    this.portrait,
    this.landscape,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrientationLayout();
}

class _OrientationLayout  extends ConsumerState<OrientationLayout> {  

  @override
  Widget build(BuildContext context) {  
    return OrientationLayoutBuilder(
      portrait: (ctx) {
        if(widget.portrait != null) {
          return widget.portrait?.call(ctx) ?? Container();
        }else if(widget.all != null) {
          return widget.all?.call(context) ?? Container();
        }

        return Container();
      },
      landscape: (ctx) {
        if(widget.landscape != null) {
          return widget.landscape?.call(ctx) ?? Container();
        }else if(widget.all != null) {
          return widget.all?.call(context) ?? Container();
        }

        return Container();
      }
    );
  }
}