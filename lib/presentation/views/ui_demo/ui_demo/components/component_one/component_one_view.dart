import 'package:flutter/material.dart';
import 'package:flutter_demo/domain/entities/component_one_entity.dart';
import 'package:flutter_demo/presentation/views/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_provider.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentOneView extends ConsumerStatefulWidget {

  const ComponentOneView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComponentOneView();
}

class _ComponentOneView  extends ConsumerState<ComponentOneView> {

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(componentOneProvider);

    List<ComponentOneItemEntity> list = List.empty(growable: true);

    for (var i = 0; i < 50; i++) {
      list.add(ComponentOneItemEntity(title: (i+1).toString()));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    ref.read(componentOneProvider.notifier).buttonSelect(ComponentOneButton.verticallyList);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        bottomLeft: Radius.circular(24.r)
                      ),
                      border: Border(
                        top: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                        left: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                        right: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                        bottom: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                      ),
                      color: state.selectedButton == ComponentOneButton.verticallyList ? Theme.of(context).colorScheme.primary.withAlpha(100) : Colors.white
                    ),
                    child: Text(
                      "vertical",
                      style: TextStyle(
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    ref.read(componentOneProvider.notifier).buttonSelect(ComponentOneButton.horizontalList);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r)
                      ),
                      color: state.selectedButton == ComponentOneButton.horizontalList ? Theme.of(context).colorScheme.primary.withAlpha(100) : Colors.white,
                      border: Border(
                        top: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                        right: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                        bottom: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                      ),
                    ),
                    child: Text(
                      "Horizon",
                      style: TextStyle(
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),
          Visibility(
            visible: state.selectedButton == ComponentOneButton.verticallyList,
            child: Container(
              height: 300,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(width: 2.w, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {

                  var item = list[index];

                  return GestureDetector(
                    onTap: () {
                      ModalDialogWidget().showModalDialogWithOkButton(
                        context: context,
                        title: "Select: ${item.title}",
                        onTap: () {
                          if(Navigator.canPop(context)) Navigator.pop(context);
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      width: MediaQuery.sizeOf(context).width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withAlpha(100),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(item.title),
                    )
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: state.selectedButton == ComponentOneButton.horizontalList,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(width: 2.w, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.antiAlias,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: [
                    for(var item in list) ... [
                      GestureDetector(
                        onTap: () {
                          ModalDialogWidget().showModalDialogWithOkButton(
                            context: context,
                            title: "Select: ${item.title}",
                            onTap: () {
                              if(Navigator.canPop(context)) Navigator.pop(context);
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.r)),
                            color: Theme.of(context).colorScheme.primary.withAlpha(100),
                          ),
                          width: 60.w,
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.h)
                    ]
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }  
}