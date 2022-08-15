class Variants {
  Variants({required this.name, required this.variants});
  final String name;
  final Map<String, String> variants;


  factory Variants.fromJson(Map<String, dynamic> data) {
    final key = data['key'] as int;
    final number = data['number'] as int;
    final name = data['name'] as String;
    final direction = data['direction'] as String;

    return Variants(name: name, key: key,number: number, direction: direction);
  }
}