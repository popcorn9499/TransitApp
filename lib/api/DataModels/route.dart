import "package:transit_app/api/DataModels/variants.dart";
//stores information on a buses route.
/*
the route name
route number
the variant names of the buses
  basically keeps track of which variant of say an 11. 11 westwood or 11 glenway or something
 */

class Route {
  static const List<dynamic>  defaultData = ["none data"];

  Route({required this.key, required this.number,required this.name, required List<String> variantKeys}) {
    List<String> tempVariantKeys = <String>[];
    String temp = "";
    //copy the variantKeys list to keep it safe from the input list being changed
    for (String element in variantKeys) {
      temp = element;
      tempVariantKeys.add(temp);
    }
    _variantKeys = tempVariantKeys;
  }
  final int key;
  final int number; //this should be the same as the key
  final String name; //this should show the route name example "Route 11 Portage-Kildonan"
  late  List<String> _variantKeys; //list of the variant keys "11-1-D"

  //turns the incoming json into a object
  factory Route.fromJson(Map<String, dynamic> data, {List <dynamic> variantsData = Route.defaultData}) {
    int key;
    int number;
    String name;
    List<dynamic> variants = <String>[];
    List<String> variantKeys = <String>[];
    //handle main data
    if (data.containsKey("route")) {
      key = data["route"]['key'] as int;
      number = data["route"]['number'] as int;
      name = data["route"]['name'] as String;
      if (data["route"].containsKey("variants")){
        print("I GOT THE KEY");
        variants = data["route"]['variants'];
        for (var element in variants) {
          String variant = element["key"];
          variantKeys.add(variant);
        }
      }
    } else {
      key = data['key'] as int;
      number = data['number'] as int;
      name = data['name'] as String;
      if (variantsData != Route.defaultData) {
        print("GOT extra data");
        for (String element in variantsData) {
          variantKeys.add(element);
        }
      }
    }






    return Route(name: name, key: key,number: number, variantKeys: variantKeys);
  }

/*
  Add details for different routes.

  Rapid Transit (Blue)
    Anything above route number 137
  Express(Yellow?)
    21,22,24,25,28,30,31,32,34,35,36,40,41,42,46,48,54,57,58,59,64,65,67
 */
  /*
    Returns a list of strings of bus variants
    this is a deep copy of the initial list
   */
  List<String> getVariants() {
    List<String> result = <String>[];
    String duplicate = "";
    for (String element in _variantKeys){ //preform a deep copy of the list to ensure the list structure is immutable
      duplicate = element;
      result.add(duplicate);
    }

    return result;
  }

  @override
  String toString() {
    String result = "Route name: $name key: $key number: $number variants: [";
    for (String element in _variantKeys) {
      result += "$element, ";
    }
    result = result.substring(0,result.length-2); //remove the last ', ' in the string to make it look cleaner
    result += "]";
    return result;
  }
}