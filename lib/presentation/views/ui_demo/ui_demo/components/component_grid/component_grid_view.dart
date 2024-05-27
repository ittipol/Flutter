import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/component_detail_entity.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentGridView extends ConsumerStatefulWidget {

  const ComponentGridView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComponentGridView();
}

class _ComponentGridView  extends ConsumerState<ComponentGridView> {  

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
                  "Grid",
                  style: TextStyle(
                    fontSize: 24.sp
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              GridView.builder(        
                itemCount: list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9/16,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];

                  return GestureDetector(
                    onTap: () async {
                      debugPrint("#########-------------- Before pushNamed [ ${RouteName.uiDemoArticleView} ]");
                      await Navigator.pushNamed(context, RouteName.uiDemoArticleView, arguments: UiDemoArticleViewArgs(
                        id: index,
                        title: item.title,
                        image: item.image,
                        tag: "grid_img_tag_$index"
                      ));
                      debugPrint("#########-------------- After pushNamed [ ${RouteName.uiDemoArticleView} ]");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: const Offset(3, 3)
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,              
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r)
                              )
                            ),
                            child: Hero(
                              tag: "grid_img_tag_$index", 
                              child: Image(
                                image: AssetImage(item.image),
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                          SizedBox(height: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            width: double.infinity,
                            child: Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  );
                }
              )
            ]
          )
        )
      ]
    );
  }
}