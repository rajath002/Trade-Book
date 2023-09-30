import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/trade_provider.dart';

class AddTradePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController modeController = TextEditingController();

  AddTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final tradeProvider =
                      Provider.of<TradeProvider>(context, listen: false);
                  final name = nameController.text;
                  final price = double.tryParse(priceController.text) ?? 0.0;
                  final mode = modeController.text;

                  if (name.isNotEmpty &&
                      price > 0 &&
                      (mode == 'buy' || mode == 'sell')) {
                    tradeProvider.addTrade(
                      time: DateTime.now(),
                      name: name,
                      price: price,
                      mode: mode,
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
