class WebViewState {

  final int loadingPercentage;

  WebViewState({
    this.loadingPercentage = 0,
  });

  WebViewState copyWith({int? loadingPercentage}) => WebViewState(
    loadingPercentage: loadingPercentage ?? this.loadingPercentage,
  );
}
