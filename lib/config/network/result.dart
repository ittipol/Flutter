abstract class Result<T> {
  const Result();

  bool get isCompleted => this is ResultSuccess<T> ? true : false; 

  T? get getData {
    if(this is ResultSuccess<T>){
      final data = this as ResultSuccess<T>;
      return data.data;
    }

    return null;
  }

  // T get(T Function(T) callBack) {

  //   if(this is ResultSuccess<T>){
  //     final data = this as ResultSuccess<T>;
  //     return data.data;
  //   }

  //   if(this is ResultError<T>){
  //     final data = this as ResultError<T>;
  //     return data.exception;
  //   }

  //   return callBack();
  // }

  Exception? get getError {
    if(this is ResultError<T>){
      final data = this as ResultError<T>;
      return data.exception;
    }

    return null;
  }
}

final class ResultSuccess<T> extends Result<T> {
  final T data;
  const ResultSuccess({required this.data});
}

final class ResultError<T> extends Result<T> {
  final Exception exception;
  const ResultError({required this.exception});
}