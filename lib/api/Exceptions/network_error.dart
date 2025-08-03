class NetworkError implements Exception {
  final String message;

  NetworkError([this.message = "A network error occurred."]);

  @override
  String toString() => "NetworkError: $message";
}