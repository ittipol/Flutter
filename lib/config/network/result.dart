abstract class Result<T> {
  const Result();

  bool get isCompleted => this is ResultSuccess<T> ? true : false; 
}

final class ResultSuccess<T> extends Result<T> {
  final T data;
  const ResultSuccess({required this.data});
}

final class ResultError<T> extends Result<T> {
  final Exception exception;
  const ResultError({required this.exception});
}