import 'package:uuid/uuid.dart';

class Trade {
  String id;
  DateTime time;
  String name;
  double price;
  String mode; // 'buy' or 'sell'
  double closingPrice = 0.0;
  double result = 0.0;

  Trade({
    required this.time,
    required this.name,
    required this.price,
    required this.mode,
    double? closingPrice = 0.0,
    double? result,
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

  set setClosingPrice(double price) {
    closingPrice = price;
  }

  set setResult(double price) {
    result = price;
  }
}
