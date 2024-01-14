sealed class Result<T> {}

class Success<T> extends Result<T> {
  Success(this.data);

  final T data;
}

class Failure<T> extends Result<T> {
  Failure(this.message);

  final String message;
}
