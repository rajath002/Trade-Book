import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/trade_provider.dart';

import '../widgets/appbar.dart';
import '../widgets/StockAutoComplete.dart';

class AddTradePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController modeController = TextEditingController();
  final TextEditingController closingPriceController = TextEditingController();

  AddTradePage({super.key});

  void getName(String name) => nameController.text = name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TradeAppBar(
        title: 'Add Trade',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StockAutoComplete(
                initialValue: "",
                callback: getName,
                labelText: "Stock name",
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: modeController,
                decoration:
                    const InputDecoration(labelText: 'Mode (buy or sell)'),
              ),
              TextFormField(
                controller: closingPriceController,
                decoration: const InputDecoration(labelText: 'Closing Price'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final tradeProvider =
                      Provider.of<TradeProvider>(context, listen: false);
                  final name = nameController.text;
                  final price = double.tryParse(priceController.text) ?? 0.0;
                  final mode = modeController.text;
                  final closingPrice =
                      double.tryParse(closingPriceController.text) ?? 0.0;

                  if (name.isNotEmpty &&
                      price > 0 &&
                      (mode == 'buy' || mode == 'sell')) {
                    tradeProvider.addTrade(
                      time: DateTime.now(),
                      name: name,
                      price: price,
                      mode: mode,
                      closingPrice: closingPrice ?? 0.0,
                    );
                    Navigator.pop(context); // Return to the previous screen
                  }
                },
                child: const Text('Add Trade'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
