import 'package:uuid/uuid.dart';

class Trade {
  String id;
  DateTime time;
  String name;
  double price;
  String mode; // 'buy' or 'sell'

  Trade({
    required this.time,
    required this.name,
    required this.price,
    required this.mode,
    String? id, // Allow id to be nullable
  }) : id = id ?? const Uuid().v4();

  set setTime(DateTime newTime) {
    time = newTime;
  }

  set setName(String newName) {
    name = newName;
  }

  set setPrice(double newPrice) {
    price = newPrice;
  }

  set setMode(String newMode) {
    mode = newMode;
  }
}
