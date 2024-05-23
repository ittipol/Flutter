import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/component_detail_entity.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/views/common/blank_page/scaffold_blank_page_widget/scaffold_blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverAppBarView extends ConsumerStatefulWidget {

  const SliverAppBarView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SliverAppBarView();
}

class _SliverAppBarView  extends ConsumerState<SliverAppBarView> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  
    WidgetsBinding.instance.addPostFrameCallback((_) async {            
      
    });
        
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

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

    return ScaffoldBlankPageWidget(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            centerTitle: true,
            backgroundColor: AppColor.primary,
            pinned: true,
            floating: true,
            snap: true,
            leading: GestureDetector(
              onTap: () {
                if(Navigator.canPop(context)) Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 24.w,
                height: 24.w,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 16.w, bottom: 4.w),                      
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 24.sp,
                )
              )
            ),
            title: const Text(
              "Flutter Demo",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.detail.path),
                    fit: BoxFit.cover
                  )
                ),
              )
            ),
            // bottom: AppBar(
            //   title: const Text('AppBar Demo'),
            // ),
          ),
          // SliverPersistentHeader(
          //   delegate: ,
          //   pinned: false,
          // ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                color: AppColor.primary.percentAlpha(70),
              ),
              height: 200.h,              
              child: const Center(
                child: Text("Text"),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                color: AppColor.primary.percentAlpha(70),
              ),
              height: 200.h,              
              child: const Center(
                child: Text("Text"),
              ),
            ),
          ),
          SliverList(            
            delegate: SliverChildBuilderDelegate((context, int index) {              
                var item = list[index];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.uiDemoArticleView, arguments: UiDemoArticleViewArgs(
                          id: index,
                          title: item.title,
                          image: item.image,
                          tag: "sliver_list_img_tag_$index"
                        ));
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Hero(
                                tag: "sliver_list_img_tag_$index", 
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
                    ),
                    SizedBox(height: 16.h)
                  ],
                );
              },
              childCount: list.length,
            ),
          ),
          SliverGrid(
            // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //   maxCrossAxisExtent: 200.0,
            //   mainAxisSpacing: 10.0,
            //   crossAxisSpacing: 0.0,
            //   childAspectRatio: 4.0,
            // ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid item $index'),
                );
              },
              childCount: 20,
            ),
          )
        ],
      ),
    );

  }

}