import 'package:flutter/material.dart';
import 'package:flutter_demo/domain/entities/component_one_entity.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_provider.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentButtonGroupAndListView extends ConsumerStatefulWidget {

  const ComponentButtonGroupAndListView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComponentButtonGroupAndListView();
}

class _ComponentButtonGroupAndListView  extends ConsumerState<ComponentButtonGroupAndListView> {

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(componentButtonGroupAndListProvider);

    List<ComponentOneItemEntity> list = List.empty(growable: true);

    for (var i = 0; i < 50; i++) {
      list.add(ComponentOneItemEntity(title: (i+1).toString()));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                    ref.read(componentButtonGroupAndListProvider.notifier).buttonSelect(ComponentButtonGroupAndListButton.verticalList);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 16.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24)
                      ),
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.blue.shade800),
                        left: BorderSide(width: 1, color: Colors.blue.shade800),
                        right: BorderSide(width: 1, color: Colors.blue.shade800),
                        bottom: BorderSide(width: 1, color: Colors.blue.shade800),
                      ),
                      color: state.selectedButton == ComponentButtonGroupAndListButton.verticalList ? Colors.blue.shade800 : Colors.grey.shade400
                    ),
                    child: Text(
                      "vertical",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    ref.read(componentButtonGroupAndListProvider.notifier).buttonSelect(ComponentButtonGroupAndListButton.horizontalList);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 16.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24)
                      ),
                      color: state.selectedButton == ComponentButtonGroupAndListButton.horizontalList ? Colors.blue.shade800 : Colors.grey.shade400,
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.blue.shade800),
                        right: BorderSide(width: 1, color: Colors.blue.shade800),
                        bottom: BorderSide(width: 1, color: Colors.blue.shade800),
                      ),
                    ),
                    child: Text(
                      "Horizon",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: Colors.white
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),
          Visibility(
            visible: state.selectedButton == ComponentButtonGroupAndListButton.verticalList,
            child: Container(
              height: 300,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                border: Border.all(width: 2.r, color: Colors.blue.shade800),
                borderRadius: const BorderRadius.all(Radius.circular(16))
              ),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.r),
                itemBuilder: (context, index) {
                  var item = list[index];

                  return GestureDetector(
                    onTap: () {
                      _showModalBottomSheet(context: context, text: "Select ${item.title} in vertical list");
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      width: MediaQuery.sizeOf(context).width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16.spMin,
                          color: Colors.white
                        ),
                      ),
                    )
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: state.selectedButton == ComponentButtonGroupAndListButton.horizontalList,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                border: Border.all(width: 2.r, color: Colors.blue.shade800),
                borderRadius: const BorderRadius.all(Radius.circular(16))
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
                          _showModalBottomSheet(context: context, text: "Select ${item.title} in horizontal list");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            color: Colors.blue.shade800,
                          ),
                          width: 60.r,
                          padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 16.r),
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.spMin,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.r)
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

  Future<dynamic> _showModalBottomSheet({required BuildContext context, required String text}) {
    return showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.spMin,
                    color: Colors.black
                  )
                ),
                SizedBox(height: 8.r),
                ElevatedButton(
                  onPressed: () {
                    if(Navigator.canPop(context)) Navigator.pop(context);
                  },           
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200
                  ),
                  child: Text(
                    "Close",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.spMin,
                      color: Colors.black
                    )
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }  
}