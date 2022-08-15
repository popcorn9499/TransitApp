class Variants {
  Variants({required this.name, required this.variants});
  final String name;
  final Map<String, String> variants;

  factory Variants.fromJson(String name, Map<String, dynamic> data) {
    final variants = data as Map<String, String>;
    return Variants(name: name, variants: variants);
  }
}