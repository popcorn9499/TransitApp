class URLGenerator {
  String url;
  URLGenerator({required this.url});

  void addParam(String key, String value) {
    url += "$key&$value";
  }

  @override
  String toString() {
    return url;
  }
}