import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/component_detail_entity.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentDetailListView extends ConsumerStatefulWidget {

  const ComponentDetailListView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComponentDetailListView();
}

class _ComponentDetailListView  extends ConsumerState<ComponentDetailListView> {

  @override
  Widget build(BuildContext context) {

    List<ComponentDetailEntity> list = List.empty(growable: true);
    list.add(ComponentDetailEntity(title: "What's new in Flutter", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Flutter Clean Architecture", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Flutter State Management", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Flutter Developer Complete Roadmap 2024", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Tailwind CSS Tutorial ", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Every React Concept Explained in 12 Minutes", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "What’s new in DevTools", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Installing the package", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "Biggest New Features", image: Assets.images.detail.path));
    list.add(ComponentDetailEntity(title: "CSS Flexbox", image: Assets.images.detail.path));
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
                    bottom: BorderSide(width: 1.w, color: Theme.of(context).colorScheme.primary.withAlpha(100))
                  )
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Article",
                  style: TextStyle(
                    fontSize: 24.sp
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
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.uiDemoArticleView, arguments: UiDemoArticleViewArgs(
                        id: index,
                        title: item.title,
                        image: item.image
                      ));
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
                              tag: "img_tag_$index", 
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
                                fontSize: 16.sp
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