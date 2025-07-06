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
import 'package:flutter_demo/presentation/views/api_service_demo/common/api_service_detail_widget/api_service_detail_widget.dart';
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
              "Search Pokemon",
              style: TextStyle(
                fontSize: 24.spMin
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: TextField(
                autofocus: true,
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
            SizedBox(height: 16.r),
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
                  child: ApiServiceDetailWidget(
                    args: ApiServiceDetailWidgetArgs(pokemonDetail: state.pokemonDetail),
                  ),
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
                    padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 16.r),
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
        ModalDialogWidget.showModalDialogWithOkButton(
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

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

}