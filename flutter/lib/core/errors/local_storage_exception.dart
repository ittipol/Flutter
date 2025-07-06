enum LocalStorageExceptionType {
  notFound,
  failure,
  none
}

class LocalStorageException implements Exception {

  String message;
  LocalStorageExceptionType type;

  LocalStorageException({
    required this.message,
    this.type = LocalStorageExceptionType.none,
  });

}