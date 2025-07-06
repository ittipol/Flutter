import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/domain/entities/component_detail_entity.dart';
import 'package:flutter_demo/gen/assets.gen.dart';
import 'package:flutter_demo/presentation/common/blank_page/scaffold_blank_page_widget/scaffold_blank_page_widget.dart';
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
    
    _scrollController.addListener(() { 
      // debugPrint(_scrollController.position.maxScrollExtent.toString());
      debugPrint(_scrollController.position.pixels.toString());
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
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,            
            backgroundColor: AppColor.primary,
            pinned: true,            
            // floating: true,
            // snap: true,
            stretch: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                if(Navigator.canPop(context)) Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 24.spMin,
                )
              )
            ),
            centerTitle: true,
            title: Text(
              "Sliver App Bar",
              style: const TextStyle().copyWith(fontSize: 16.spMin, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(              
              background: Image(
                image: AssetImage(Assets.images.detail.path),
                fit: BoxFit.cover,
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                // StretchMode.fadeTitle,
                // StretchMode.zoomBackground
              ]
            ),
            // bottom: const PreferredSize(
            //   preferredSize: Size.fromHeight(10),
            //   child: SizedBox(),
            // )
          ),
          // SliverAppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   pinned: true,
          //   leading: Container(),
          //   flexibleSpace: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 16.w),
          //     child: TextField(

          //     )
          //   )
          // ),
          // SliverPersistentHeader(
          //   delegate: ,
          //   pinned: false,
          // ),
          SliverFillRemaining(
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.shade200,
                child: Center(
                    child: Text(
                    "Text",
                    style: TextStyle(
                      fontSize: 24.spMin,
                      color: Colors.black
                    )
                  )
                )
              )
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: AppColor.primary.percentAlpha(70),
              ),
              height: 200.h,              
              child: Center(
                  child: Text(
                  "Text",
                  style: TextStyle(
                    fontSize: 24.spMin,
                    color: Colors.white
                  )
                )
              )
            )
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: EdgeInsets.all(16.w),
          //     decoration: BoxDecoration(
          //       borderRadius: const BorderRadius.all(Radius.circular(8)),
          //       color: AppColor.primary.percentAlpha(70),
          //     ),
          //     height: 200.h,              
          //     child: const Center(
          //       child: Text("Text"),
          //     ),
          //   ),
          // ),
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
                                  fontSize: 16.spMin
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