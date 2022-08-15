class BusStop {
  BusStop({required this.key,required this.number,required this.name,required this.direction});
  final int key;
  final int number;
  final String name;
  final String direction;

  factory BusStop.fromJson(Map<String, dynamic> data) {
    final key = data['key'] as int;
    final number = data['number'] as int;
    final name = data['name'] as String;
    final direction = data['direction'] as String;

    return BusStop(name: name, key: key,number: number, direction: direction);
  }
}