// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/TransitManager.dart';


void main() {

  test('Test Transit Manager Creation', () async {
    TransitManager manager = TransitManager();
  });

  test('Test Transit Manager getJson', () async {
    TransitManager manager = TransitManager();
    Map<String, dynamic> data = manager.getJson("https://jsonplaceholder.typicode.com/albums/1");
    Map<String, dynamic> testData = {
      "userId": 1,
      "title": "quidem molestiae enim"
    };
    expect(data, equals(testData));
  });

  test('Test Transit Manager genSearchQueryURL', () async {
    TransitManager manager = TransitManager();
    String url = manager.genSearchQueryURL("coolStop");
    int apiIndex = url.lastIndexOf("api-key");
    expect(url.substring(0, apiIndex +8), equals("https://api.winnipegtransit.com/v3/stops:coolStop.json?usage=short&api-key="));
  });
}
