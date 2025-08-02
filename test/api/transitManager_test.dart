// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';


void main() {

  test('Test Transit Manager Creation', () async {
    TransitManager manager = TransitManager();
  });

  test('Test Transit Manager getJson', () async {
    TransitManager manager = TransitManager();
    Map<String, dynamic> data = await manager.getJson("https://jsonplaceholder.typicode.com/albums/1");
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

  test('Test Transit Manager genSearchQuery', () async {
    TransitManager manager = TransitManager();
    String search = "10611";
    List<BusStop> stops = await manager.genSearchQuery(search);

    expect(stops[0].toString(), equals("Stop #10611 at EB Graham@Fort (Wpg Square) direction Eastbound"));
  });

  test('Test Transit Manager genStopNumbers', () async {
    TransitManager manager = TransitManager();
    BusStopSchedules stops;
    stops = await manager.genStopNumbers("10611");
    //no real checks just ensures the code functions
  });

  test('Test Transit Manager genStopNumbers names', () async {
    TransitManager manager = TransitManager();
    String search = "Fort";
    List<BusStop> stops = await manager.genSearchQuery(search);
    print(stops);
    expect(stops.toString(), equals("[Stop #10644 at NB Fort@Graham North direction Northbound, Stop #10643 at NB Fort@Graham direction Northbound, Stop #10646 at NB Fort@Portage direction Northbound, Stop #10830 at NB Fort@Assiniboine direction Northbound, Stop #11010 at NB Fort@Broadway direction Northbound, Stop #11024 at NB Fort@St. Mary direction Northbound, Stop #11038 at SB Fort Rouge Station@Fort Rouge Station (95 to Riverview) direction Southbound, Stop #11037 at SB Fort Rouge Station@Fort Rouge Station (Route 95) direction Southbound]"));
    //no real checks just ensures the code functions
  });
}
