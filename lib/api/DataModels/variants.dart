import 'variant.dart';


class Variants {
  Variants({required this.name, required this.variants});
  final String name;
  final List<Variant> variants;

  //preform a shallow copy of the list to ensure the list structure is immutable
  List<Variant> getVariants() {
    List<Variant> result = [];
    for (Variant element in variants){
      result.add(element);
    }
    return result;
  }

  @override
  String toString() {
    String result = "$name: $variants";
    return result;
  }

  //take the json input map and return a constructed Variants obj
  factory Variants.fromJson(String name, Map<String, dynamic> data) {
    List<dynamic> variantsData = data["variants"];
    List<Variant> variants = [];
    for (var element in variantsData) {
      String elemKey = element["key"] as String;
      String elemName = element["name"] as String;
      Variant variant = Variant(key: elemKey, name: elemName);
      variants.add(variant);
    }

    return Variants(name: name, variants: variants);
  }
}
