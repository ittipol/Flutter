abstract class Result<T> {
  const Result();

  bool get isCompleted => this is ResultComplete<T> ? true : false; 

  T? get getData {
    if(this is ResultComplete<T>){
      final result = this as ResultComplete<T>;
      return result.data;
    }

    return null;
  }

  Exception? get getError {
    if(this is ResultError<T>){
      final result = this as ResultError<T>;
      return result.exception;
    }

    return null;
  }

  R when<R>({
    required R Function(ResultComplete<T>) completeWithValue, 
    required R Function(ResultError<T>) completeWithError,
    void Function()? complete
  }) {

    R? result;

    if(this is ResultComplete<T>){
      result = completeWithValue.call(this as ResultComplete<T>);
    }
    
    if(this is ResultError<T>){
      result = completeWithError.call(this as ResultError<T>);
    }

    complete?.call();

    return result as R;
  }
}

final class ResultComplete<T> extends Result<T> {
  final T data;
  const ResultComplete({required this.data});
}

final class ResultError<T> extends Result<T> {
  final Exception exception;
  final int? httpStatusCode;
  const ResultError({required this.exception, this.httpStatusCode});
}