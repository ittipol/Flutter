import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_state.dart';
import 'package:flutter_demo/presentation/views/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiServiceIndexView extends ConsumerStatefulWidget {

  const ApiServiceIndexView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiServiceIndexView();
}

class _ApiServiceIndexView  extends ConsumerState<ApiServiceIndexView> {

  bool loading = false;
  int offset = 0;
  int limit = 20;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {            
      await _getPokemonIndex();
    });

  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(apiServiceIndexProvider);

    return BlankPageWidget(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Pokemon index",
              style: TextStyle(
                fontSize: 24.sp
              )
            )
          ),
          Visibility(
            visible: state.status == ApiServiceIndexStateStatus.loading,
            child: Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ),
          ),
          Visibility(
            visible: state.status == ApiServiceIndexStateStatus.success,
            child: Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [                      
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.apiServiceSearchView);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withAlpha(500),
                            borderRadius: BorderRadius.all(Radius.circular(32.r))
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Search",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white
                                  ),
                                )
                              ),
                              SizedBox(width: 8.w),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(32.r)),
                      //     border: Border.all(color: Colors.black, width: 1),
                      //     color: Theme.of(context).colorScheme.primary.withAlpha(500)
                      //   ),
                      //   child: FittedBox(
                      //     alignment: Alignment.center,
                      //     fit: BoxFit.fill,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Image(
                      //           image: AssetImage(""),
                      //           width: 12.w,
                      //           height: 16.w,
                      //         ),
                      //         SizedBox(width: 8.w),
                      //         Text(
                      //           "Search",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 16.sp
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 8.h),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _paginationCounter(state),
                          style: TextStyle(
                            fontSize: 16.sp
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.pokemon?.results?.length ?? 0,
                          separatorBuilder: (context, index) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {

                            var item = state.pokemon?.results?[index];

                            if(item == null) {
                              return Container();
                            }                                         

                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RouteName.apiServiceDetailView, arguments: ApiServiceDetailViewArgs(
                                  name: item.name ?? ""
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Colors.black87),
                                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 30.h,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24.r),
                                                bottomLeft: Radius.circular(24.r)
                                              )
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent.shade700,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(24.r),
                                                bottomRight: Radius.circular(24.r)
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Colors.transparent),
                                      color: Colors.transparent
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {                              
                                _delayedTab(() {
                                  if(offset - limit < 0) {
                                    return;
                                  }

                                  offset -= limit;
                                  _getPokemonIndex();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,                            
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  color: (offset - limit < 0) ?Colors.grey.shade200 : Colors.blue.shade600
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                                child: Text(
                                  "Previous",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: (offset - limit < 0) ? Colors.black87 : Colors.white
                                  ),
                                ),
                              )
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                _delayedTab(() {
                                  if(offset + limit > (state.pokemon?.count ?? 0)) {
                                    return;
                                  }

                                  offset += limit;
                                  _getPokemonIndex();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,                            
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  color: (offset + limit > (state.pokemon?.count ?? 0)) ? Colors.grey.shade200 :Colors.blue.shade600
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                                child: Text(
                                  "Next",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: (offset + limit > (state.pokemon?.count ?? 0)) ? Colors.black87 : Colors.white
                                  ),
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.h)
                    ],
                  ),
                )
              ),
            ),
        ],
      )
    );

  }

  Future _getPokemonIndex() async {
    var result = await ref.read(apiServiceIndexProvider.notifier).getPokemonIndex(offset: offset, limit: limit);

    if(result is ResultError) {
      var error = (result as ResultError).exception;

      var message = "something went wrong. Please try again later";

      if(error is DioException) {
        message = "Connection Error";
      }

      ModalDialogWidget().showModalDialogWithOkButton(
        context: context,
        title: message,
        onTap: () {
          if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.home);
        },
      );
      
    }
  }

  String _paginationCounter(ApiServiceIndexState state) {

    var pagination = offset+limit;

    if(pagination > (state.pokemon?.count ?? 0)) {
      pagination = (state.pokemon?.count ?? 0);
    }

    return "${(offset+1).toString()}-${pagination.toString()} / ${state.pokemon?.count.toString()}";
  }

  Future<void> _delayedTab(Function() func) async {
    if (loading) return;
    loading = true;

    func();

    await Future.delayed(const Duration(milliseconds: 1000)).then((v) {loading = false;});
  }  

}