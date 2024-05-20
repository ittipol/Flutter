sealed class Result<T> {
  const Result();
}

class ResultSuccess<T> extends Result<T> {
  final T data;
  const ResultSuccess({required this.data});
}

class ResultError<T> extends Result<T> {
  final Exception exception;
  const ResultError({required this.exception});
}