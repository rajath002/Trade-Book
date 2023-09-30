
import 'package:flutter_new/models/trade.dart';

List<Trade> sampleTrades = [
  Trade(
    time: DateTime(2023, 9, 30, 10, 15), // Example time
    name: 'Apple Inc.',
    price: 150.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 10, 30), // Example time
    name: 'Microsoft Corporation',
    price: 300.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 11, 45), // Example time
    name: 'Tesla, Inc.',
    price: 800.0,
    mode: 'sell',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 12, 15), // Example time
    name: 'Amazon.com, Inc.',
    price: 3500.0,
    mode: 'buy',
  ),
  Trade(
    time: DateTime(2023, 9, 30, 14, 0), // Example time
    name: 'Google LLC',
    price: 2700.0,
    mode: 'sell',
  ),
  // Add more sample trades as needed
];