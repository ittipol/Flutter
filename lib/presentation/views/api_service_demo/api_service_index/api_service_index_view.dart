import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_state.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Text(
              "Pokemon index",
              style: TextStyle(
                fontSize: 24.spMin
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
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Column(
                    children: [                      
                      SizedBox(height: 8.r),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.apiServiceSearchView);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(32)),
                            border: Border.all(color: Colors.grey.shade400, width: 1),
                            color: Colors.white
                          ),
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            child: SizedBox(
                              width: 200.r,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.black
                                  ),
                                  SizedBox(width: 8.r),
                                  Text(
                                    "Search",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.spMin
                                    )
                                  )
                                ]
                              ),
                            )
                          )
                        )
                      ),
                      SizedBox(height: 8.r),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _paginationCounter(state),
                          style: TextStyle(
                            fontSize: 16.spMin
                          ),
                        ),
                      ),
                      SizedBox(height: 16.r),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.pokemon?.results?.length ?? 0,
                          separatorBuilder: (context, index) => SizedBox(height: 16.r),
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
                                      border: Border.all(width: 2, color: Theme.of(context).colorScheme.onSurface),
                                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 40.r,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                bottomLeft: Radius.circular(24)
                                              )
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent.shade700,
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(24),
                                                bottomRight: Radius.circular(24)
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Colors.transparent),
                                      color: Colors.transparent
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.catching_pokemon,
                                            size: 32.spMin,
                                            color: Colors.redAccent.shade700
                                          ),
                                          SizedBox(width: 8.r),
                                          Expanded(
                                            child: Text(
                                              item.name ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.spMin,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.r),
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
                      SizedBox(height: 16.r),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  color: (offset - limit < 0) ?Colors.grey.shade200 : Colors.blue.shade600
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 24.r),
                                child: Text(
                                  "Previous",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: (offset - limit < 0) ? Colors.black87 : Colors.white,
                                    fontSize: 16.spMin
                                  ),
                                ),
                              )
                            ),
                          ),
                          SizedBox(width: 16.r),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  color: (offset + limit > (state.pokemon?.count ?? 0)) ? Colors.grey.shade200 :Colors.blue.shade600
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 24.r),
                                child: Text(
                                  "Next",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: (offset + limit > (state.pokemon?.count ?? 0)) ? Colors.black87 : Colors.white,
                                    fontSize: 16.spMin
                                  ),
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.r)
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

      ModalDialogWidget.showModalDialogWithOkButton(
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