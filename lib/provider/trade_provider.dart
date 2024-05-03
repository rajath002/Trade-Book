import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_new/mock/sample_trades.dart';

import '../models/trade.dart';

class TradeProvider extends ChangeNotifier {
  List<Trade> trades = sampleTrades;
  Client client = Client();

  final _endPoint = dotenv.env['AW_ENDPOINT'];
  final _project = dotenv.env['AW_PROJECT'];
  final _databaseId = dotenv.env['AW_DATABASE_ID'];
  final _collectionId = dotenv.env['AW_COLLECTION_ID'];

  Future<void> readData() async {
    try {
      client.setEndpoint(_endPoint!).setProject(_project).setSelfSigned(
            status: true,
          ); // For self signed certificates, only use for development
      final databases = Databases(client);
      print(databases.client.config);
      print(databases.toString());
      final response = await databases.listDocuments(
        databaseId: _databaseId ?? '',
        collectionId: _collectionId ?? '',
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  // Method to add a trade
  void addTrade({
    required DateTime time,
    required String name,
    required double price,
    required String mode,
    required double closingPrice,
  }) {
    double result = 0.0;
    if (closingPrice != 0 && price != 0) {
      result = closingPrice - price;
    }
    final newTrade = Trade(
      time: time,
      name: name,
      price: price,
      mode: mode,
      closingPrice: closingPrice ?? 0.0,
      result: result
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
    double? closingPrice,
  }) {
    final tradeIndex = trades.indexWhere((trade) => trade.id == id);

    double result = 0.0;
    if (closingPrice != 0 && price != 0) {
      result = (closingPrice ?? 0.0) - (price ?? 0.0);
    }

    if (tradeIndex != -1) {
      final trade = trades[tradeIndex];
      if (time != null) trade.setTime = time;
      if (name != null) trade.setName = name;
      if (price != null) trade.setPrice = price;
      if (mode != null) trade.setMode = mode;
      if (closingPrice != null) trade.setClosingPrice = closingPrice;
      if (result != null && result != 0) trade.result = result;

      notifyListeners();
    }
  }
}
