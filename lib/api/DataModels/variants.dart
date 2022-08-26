import 'variant.dart';


class Variants {
  Variants({required this.name, required List<Variant> variants}) {
    List<Variant> variantsCopy = <Variant>[];
    Variant temp;
    //preform a deep copy on the list
    for (Variant element in variants){
      temp = Variant(name: element.name, key: element.key);
      variantsCopy.add(temp);
    }
    _variants = variantsCopy;
  }
  final String name;
  late List<Variant> _variants;

  //preform a shallow copy of the list to ensure the list structure is immutable
  List<Variant> getVariants() {
    List<Variant> result = [];
    for (Variant element in _variants){
      result.add(element);
    }
    return result;
  }

  @override
  String toString() {
    String result = "$name: $_variants";
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
