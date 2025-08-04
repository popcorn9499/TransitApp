// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/transit_manager.dart';


void main() {

  test('Test Transit Manager Creation', () async {
    TransitManager();
  });

  test('Test Transit Manager getJson', () async {
    TransitManager manager = TransitManager();
    Map<String, dynamic> data = await manager.getJson("https://raw.githubusercontent.com/popcorn9499/TransitApp/refs/heads/master/test/test.json");
    Map<String, dynamic> testData = {
      "userId": 1,
      "id": 1,
      "title": "quidem molestiae enim"
    };
    expect(data, equals(testData));
  });

  test('Test Transit Manager genSearchQueryURL', () async {
    TransitManager manager = TransitManager();
    String url = manager.genSearchQueryURL("coolStop");
    int apiIndex = url.lastIndexOf("api-key");
    expect(url.substring(0, apiIndex +8), equals("https://api.winnipegtransit.com/v4/stops:coolStop.json?usage=short&api-key="));
  });

  test('Test Transit Manager genSearchQuery', () async {
    TransitManager manager = TransitManager();
    String search = "10611";
    List<BusStop> stops = await manager.genSearchQuery(search);

    expect(stops[0].toString(), equals("Stop #10611 at EB Graham@Fort (Wpg Square) direction Eastbound"));
  });

  test('Test Transit Manager genStopNumbers', () async {
    TransitManager manager = TransitManager();
    await manager.genStopNumbers("10611");
    //no real checks just ensures the code functions
    //TODO add stuff to this test
  });

  test('Test Transit Manager genStopNumbers names', () async {
    TransitManager manager = TransitManager();
    String search = "Fort";
    List<BusStop> stops = await manager.genSearchQuery(search);
    if (kDebugMode) {
      print(stops);
    }
    // TODO stub network away for testing.
    // should sub in my own api data base server. So realistically I should stub all the network stuff
    expect(stops.toString(), equals("[Stop #10646 at NB Fort@Portage direction Northbound, Stop #11037 at SB Fort Rouge Station@Fort Rouge Station (F5, 557 to Windermere) direction Southbound, Stop #62044 at NB Fort Whyte@Fort Whyte Alive direction Northbound, Stop #11038 at SB Fort Rouge Station@Fort Rouge Station (557 to Sage Creek) direction Southbound]"));
    //no real checks just ensures the code functions
  });
}
