import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_provider.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_state.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/common/api_service_detail_widget/api_service_detail_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    switch (state.status) {
      case ApiServiceDetailStateStatus.loading:
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary
          )
        );
      case ApiServiceDetailStateStatus.success:
        return ApiServiceDetailWidget(
          args: ApiServiceDetailWidgetArgs(pokemonDetail: state.pokemonDetail),
        );
      default:
        return Container();
    }
  }  

}