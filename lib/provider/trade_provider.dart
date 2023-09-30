import 'package:flutter/material.dart';
import 'package:flutter_new/mock/sample_trades.dart';

import '../models/trade.dart';

class TradeProvider extends ChangeNotifier {
  List<Trade> trades = sampleTrades;

  // Method to add a trade
  void addTrade({
    required DateTime time,
    required String name,
    required double price,
    required String mode,
  }) {
    final newTrade = Trade(
      time: time,
      name: name,
      price: price,
      mode: mode,
    );
    trades.add(newTrade);

    notifyListeners();
  }

  // Method to delete a trade
  void deleteTrade(int index) {
    if (index >= 0 && index < trades.length) {
      trades.removeAt(index);

      notifyListeners();
    }
  }

  void updateTrade(
    String id, {
    DateTime? time,
    String? name,
    double? price,
    String? mode,
  }) {
    final tradeIndex = trades.indexWhere((trade) => trade.id == id);

    if (tradeIndex != -1) {
      final trade = trades[tradeIndex];
      if (time != null) trade.setTime = time;
      if (name != null) trade.setName = name;
      if (price != null) trade.setPrice = price;
      if (mode != null) trade.setMode = mode;

      notifyListeners();
    }
  }
}
