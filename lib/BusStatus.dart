

enum BusStatus { Ok, Late, Early }

//meant to convert the enum to a string
extension ParseToString on BusStatus {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last;
  }
}