import "package:transit_app/api/DataModels/variants.dart";

class Route {
  Route({required this.key,required this.number,required this.name,required this.variantKeys});
  final int key;
  final int number; //this should be the same as the key
  final String name; //this should show the route name example "Route 11 Portage-Kildonan"
  final List<String> variantKeys; //list of the variant keys "11-1-D"

  factory Route.fromJson(Map<String, dynamic> data) {
    final key = data['key'] as int;
    final number = data['number'] as int;
    final name = data['name'] as String;
    List<dynamic> variants = data['variants'];
    List<String> variantKeys = <String>[];

    for (var element in variants) {
      String variant = element["key"];
      variantKeys.add(variant);
    }

    return Route(name: name, key: key,number: number, variantKeys: variantKeys);
  }
}