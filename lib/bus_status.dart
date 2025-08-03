

enum BusStatus { ok, late, early, cancelled }

//meant to convert the enum to a string
extension ParseToString on BusStatus {
  String toShortString() {
    final raw = toString().split('.').last;
    return raw[0].toUpperCase() + raw.substring(1);
  }
}