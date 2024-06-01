import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/common/responsive_layout/responsive_layout.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_state.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiServiceSearchView extends ConsumerStatefulWidget {

  const ApiServiceSearchView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiServiceSearchView();
}

class _ApiServiceSearchView  extends ConsumerState<ApiServiceSearchView> {

  Timer? timer;

  @override
  void dispose(){
    
    if(timer != null && timer!.isActive) {
      timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(apiServiceSearchProvider);

    return BlankPageWidget(
      body: ResponsiveLayout(
        desktop: (ctx) {
          return _build(context: ctx, state: state, width: MediaQuery.sizeOf(ctx).width * 0.7);
        },
        mobile: (ctx) {
          return _build(context: ctx, state: state, width: MediaQuery.sizeOf(ctx).width);
        },
      )
    );
  }

  Widget _build({required BuildContext context, required ApiServiceSearchState state, required double width}) {
    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Text(
              "Pokemon search",
              style: TextStyle(
                fontSize: 24.spMin
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                onChanged: (value) {
        
                  if(timer != null && timer!.isActive) {
                    timer?.cancel();
                  }
        
                  timer = Timer(const Duration(milliseconds: 1100), () async {                        
                    await _searchPokemon(value);                  
                    // if (context.mounted) _hideKeyboard(context);
                  });
                }        
              ),
            ),
            Visibility(
              visible: state.status == ApiServiceSearchStateStatus.loading,
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
              visible: state.status == ApiServiceSearchStateStatus.success,
              child: Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  physics: const ClampingScrollPhysics(),
                  // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 200.h,
                          maxHeight: 200.h,
                          maxWidth: double.infinity
                        ),
                        child: _image(state),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        alignment: Alignment.center,
                        child: Text(
                          state.pokemonDetail?.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24.spMin
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                _getHeight(state.pokemonDetail?.height ?? 0),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.spMin
                                )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _getWeight(state.pokemonDetail?.weight ?? 0),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.spMin
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Theme.of(context).colorScheme.primary.withAlpha(100),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 40.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type:",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.spMin
                              )
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.pokemonDetail?.types?.length ?? 0,
                                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                                itemBuilder: (context, index) {
        
                                  var item = state.pokemonDetail?.types?[index];
        
                                  if(item == null) {
                                    return Container();
                                  }
        
                                  return Text(
                                    item.type?.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.spMin
                                    )
                                  );
                                },
                              )
                            )
                          ],
                        )
                      )
                    ],
                  )
                )
              ),
            ),
            Visibility(
              visible: state.status == ApiServiceSearchStateStatus.failure,
              child: Expanded(
                child: Center(
                  child: Container(                  
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                    child: Text(
                      "Not found",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: Colors.black87
                      ),
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _searchPokemon(String name) async {
    var result = await ref.read(apiServiceSearchProvider.notifier).searchPokemon(name);    

    if(result is ResultError) {
      var showErrorModalDialog = true;
      var error = (result as ResultError).exception;

      var message = "something went wrong. Please try again later";

      if(error is DioException) {

        if(error.response?.statusCode == 404) {
          showErrorModalDialog = false;
        }

        message = "Connection Error";
      }

      if(showErrorModalDialog) {
        ModalDialogWidget().showModalDialogWithOkButton(
          context: context,
          title: message,
          onTap: () {
            if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.home);
          },
        );
      }      
    }else if(name.isNotEmpty) {
      if (context.mounted) _hideKeyboard(context);
    }
  }

  Widget _image(ApiServiceSearchState state) {

    var image = state.pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault ?? "";

    if(image.isEmpty) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: Center(
          child: Text(
            "Image not found",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.spMin,
              color: Colors.black87
            ),
          ),
        ),
      );
    }

    return Image.network(
      image,
      height: double.infinity,
      width: double.infinity
    );
  }

  String _getHeight(int height) {

    var metre = (height * 0.1).toStringAsFixed(1);

    return "Height: ${metre.toString()} metres";
  }

  String _getWeight(int weight) {

    var kg = (weight * 0.1).toStringAsFixed(1);

    return "Weight: ${kg.toString()} kg";
  }

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

}