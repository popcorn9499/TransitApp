

enum BusStatus { Ok, Late, Early, Cancelled }

//meant to convert the enum to a string
extension ParseToString on BusStatus {
  String toShortString() {
    return toString()
        .split('.')
        .last;
  }
}