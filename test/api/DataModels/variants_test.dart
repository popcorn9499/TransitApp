// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/variant.dart';
import 'package:transit_app/api/DataModels/variants.dart';

void main() {
  test('Test Variants Creation', () async {
    List<Variant> variantsList = <Variant>[];
    Variant variant = Variant(name: "hello",key: "goodbye");
    variantsList.add(variant);
    Variants variants = Variants(name: "hello", variants: variantsList);

    //check name variable
    expect(variants.name, equals("hello"), reason: "ensure the name is correctly saved");


  });
  test('Test variants getVariants', () async {
    List<Variant> variantsList = <Variant>[];
    Variant variant = Variant(name: "hello",key: "goodbye");
    variantsList.add(variant);
    Variants variants = Variants(name: "hello", variants: variantsList);
    //check list
    expect(variants.getVariants() == variantsList, equals(false), reason: "ensure the lists arent identical in terms of memory locations");
    //create a new variant to add to this list to verify it isn't just a shallow copy
    variant = Variant(name: "HI", key: "GOOOD");
    variantsList.add(variant);
    expect(compareList(variants.getVariants(), variantsList), equals(false), reason: "checking if the list contents are equal");
  });

  test('Test Variants toString', () async {
    List<Variant> variantsList = <Variant>[];
    Variant variant = Variant(name: "hello",key: "goodbye");
    variantsList.add(variant);
    Variants variants = Variants(name: "hello", variants: variantsList);

    expect(variants.toString(), equals("hello: [goodbye: hello]"));
  });

  test('Test Variants fromJson', () async {
    List<Variant> variantsList = <Variant>[];
    //copy of json from a actual api request
    Variants variants = Variants.fromJson("16", {"variants":[{"key":"16-0-s","name":"Selkirk-Osborne to St.Vital Center"},{"key":"16-0-B","name":"Selkirk-Osborne to Tyndall Park via Burrows"}],"query-time":"2022-10-19T21:09:38"});

    expect(variants.toString(), equals("16: [16-0-s: Selkirk-Osborne to St.Vital Center, 16-0-B: Selkirk-Osborne to Tyndall Park via Burrows]"));
  });
}


bool compareList(List<dynamic> list, List<dynamic> other){
  bool result = true;
  if (list.length != other.length) {
    result = false;
  }

  for (var element in list) {
    if (!other.contains(element)){
      result = false;
    }
  }

  return result;
}
