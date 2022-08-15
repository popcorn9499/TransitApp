class Variant {
  Variant({required this.name, required this.key});
  final String name;
  final String key;

  @override
  String toString() {
    String result = "$key: $name";
    return result;
  }
}
