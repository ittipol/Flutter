import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_state.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail_image/api_service_detail_image_view.dart';
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

      result.when(
        completeWithValue: (value) {},
        completeWithError: (error) async {
          var message = "something went wrong. Please try again later";

          if(error is DioException) {
            message = "Connection Error";
          }

          if(context.mounted) {
            await ModalDialogWidget.showModalDialogWithOkButton(
              context: context,
              title: message,
              onTap: () {
                if(Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.settings.name == RouteName.home);
              },
              useInsetPadding: true
            );
          }
        }
      );

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

    final image = state.pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault ?? "";

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
              Visibility(
                visible: image.isNotEmpty,
                child: Text(
                  "Tab image to view or zoom image",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.spMin
                  )
                ),
              ),
              SizedBox(height: 8.r),
              GestureDetector(
                onTap: () {                  

                  if(image.isEmpty) {
                    return;
                  }

                  Navigator.of(context).pushNamed(RouteName.apiServiceDetailImageView, arguments: ApiServiceDetailImageViewArgs(
                    image: image
                  ));
                },
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 200.r,
                    maxHeight: 200.r,
                    maxWidth: double.infinity
                  ),
                  child: _image(image)
                )
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                child: Text(
                  widget.args.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24.spMin
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                padding: EdgeInsets.symmetric(horizontal: 40.r),
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
                    SizedBox(width: 16.r),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.pokemonDetail?.types?.length ?? 0,
                        separatorBuilder: (context, index) => SizedBox(height: 8.r),
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
          );
      default:
        return Container();
    }
  }

  Widget _image(String image) {

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

    return Hero(
      tag: "image_viewer",
      child: Image.network(
        image,
        height: double.infinity,
        width: double.infinity
      ),
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