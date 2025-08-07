import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarWidget<T extends AutoDisposeStateProvider<int>> extends ConsumerStatefulWidget {

  final T tabIndexProvider;
  final List<Widget> destinations;
  final Function(int)? onDestinationSelected;

  const NavigationBarWidget({
    required this.tabIndexProvider,
    required this.destinations,
    this.onDestinationSelected,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationBarWidget();
}

class _NavigationBarWidget  extends ConsumerState<NavigationBarWidget> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {  

    final selectedIndex = ref.watch<int>(widget.tabIndexProvider);

    return NavigationBar(
      onDestinationSelected: (int index) {
        ref.read(widget.tabIndexProvider.notifier).state = index;

        if(widget.onDestinationSelected != null) {
          widget.onDestinationSelected?.call(index);
        }
      },
      indicatorColor: Colors.amber,
      selectedIndex: selectedIndex,
      destinations: widget.destinations,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,   
    );
  }

  // tab(Function() func) async {
  //   if (loading) return;
  //   loading = true;

  //   await func();

  //   await Future.delayed(const Duration(milliseconds: 100)).then((v) {loading = false;});
  // }
}