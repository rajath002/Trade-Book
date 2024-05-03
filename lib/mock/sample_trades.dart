
import 'package:flutter_new/models/trade.dart';

List<Trade> sampleTrades = [
  Trade(
    time: DateTime(2023, 9, 30, 10, 15),
    name: 'Apple Inc.',
    price: 150.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 10, 30),
    name: 'Microsoft Corporation',
    price: 300.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 11, 45),
    name: 'Tesla, Inc.',
    price: 800.0,
    mode: 'sell',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 12, 15),
    name: 'Amazon.com, Inc.',
    price: 3500.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 14, 0),
    name: 'Google LLC',
    price: 2700.0,
    mode: 'sell',
  ),
  // Add more sample trades as needed
];