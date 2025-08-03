class NetworkError implements Exception {
  final _message;

  NetworkError([this._message]);

  @override
  String toString() {
    return "$_message";
  }
}