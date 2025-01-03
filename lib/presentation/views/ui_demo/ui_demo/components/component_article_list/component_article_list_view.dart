import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/component_detail_entity.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentArticleListView extends ConsumerStatefulWidget {

  const ComponentArticleListView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComponentArticleListView();
}

class _ComponentArticleListView  extends ConsumerState<ComponentArticleListView> {  

  @override
  Widget build(BuildContext context) {    

    List<ComponentDetailEntity> list = List.empty(growable: true);
    list.add(ComponentDetailEntity(title: "What's new in Flutter", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Flutter Clean Architecture", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Tailwind CSS Tutorial ", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Every React Concept Explained in 12 Minutes", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "What’s new in DevTools", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Next-Gen Graphics Tech Demo", image: Assets.images.detail.path));

    return Column(
      children: [        
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.w, color: AppColor.primary.percentAlpha(50))
                  )
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "List",
                  style: TextStyle(
                    fontSize: 24.spMin
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              ListView.separated(
                shrinkWrap: true,
                clipBehavior: Clip.none,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  var item = list[index];

                  return GestureDetector(
                    onTap: () async {
                      debugPrint("#########-------------- Before pushNamed [ ${RouteName.uiDemoArticleView} ]");
                      await Navigator.pushNamed(context, RouteName.uiDemoArticleView, arguments: UiDemoArticleViewArgs(
                        id: index,
                        title: item.title,
                        image: item.image,
                        tag: "article_list_img_tag_$index"
                      ));
                      debugPrint("#########-------------- After pushNamed [ ${RouteName.uiDemoArticleView} ]");
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Hero(
                              tag: "article_list_img_tag_$index", 
                              child: Image(image: AssetImage(item.image))
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 1,
                            child: Text(
                              item.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16.spMin
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          )
        )
      ],
    );
  }

}