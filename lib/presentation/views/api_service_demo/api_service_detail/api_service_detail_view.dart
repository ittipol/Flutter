import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_state.dart';
import 'package:flutter_demo/presentation/views/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiServiceDetailViewArgs {
  final String name;

  ApiServiceDetailViewArgs({
    required this.name
  });
}

class ApiServiceDetailView extends ConsumerStatefulWidget {

  final ApiServiceDetailViewArgs args;

  const ApiServiceDetailView({
    required this.args,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiServiceDetailView();
}

class _ApiServiceDetailView  extends ConsumerState<ApiServiceDetailView> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {            

      var result = await ref.read(apiServiceDetailProvider.notifier).getPokemonDetail(widget.args.name);

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
    });

  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(apiServiceDetailProvider);

    return BlankPageWidget(
      body: _build(state),
    );
  }

  Widget _build(ApiServiceDetailState state) {

    switch (state.status) {
      case ApiServiceDetailStateStatus.loading:
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary
          )
        );
        case ApiServiceDetailStateStatus.success:
          return Column(
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
                  widget.args.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24.sp
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
                          fontSize: 16.sp
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
                          fontSize: 16.sp
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
                        fontSize: 16.sp
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
                              fontSize: 16.sp
                            )
                          );
                        },
                      )
                    )
                  ],
                )
              )
            ],
          );
      default:
        return Container();
    }
  }

  Widget _image(ApiServiceDetailState state) {

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
              fontSize: 16.sp,
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

}