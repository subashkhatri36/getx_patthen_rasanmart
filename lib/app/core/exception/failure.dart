class NetworkFailure implements Exception {
  final String message;

  NetworkFailure({this.message});
}

class ValueFailure implements Exception {
  final String message;

  ValueFailure({this.message});
}

class NetworkImageLoadFailure implements Exception {
  final String message;

  NetworkImageLoadFailure({this.message});
}

class LogInFailure implements Exception {
  final String message;

  LogInFailure({this.message});
}

class RouteNotFound implements Exception {
  final String message;
  RouteNotFound({this.message});
}
