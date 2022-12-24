class URLGenerator {
  String url;
  URLGenerator({required this.url});

  void addParam(String key, String value) {
    url += "&$key=$value";
  }

  void addParamList(String key, List<String> values) {

  }

  @override
  String toString() {
    var regex = RegExp('\\s'); //handle replacing spaces with +
    return url.replaceAll(regex, "+");
  }
}