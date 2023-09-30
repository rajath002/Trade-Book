import 'package:flutter/material.dart';
import 'package:flutter_new/models/trade.dart';
import 'package:flutter_new/provider/trade_provider.dart';
import 'package:provider/provider.dart';

class EditTradePage extends StatefulWidget {
  // Define a constructor to pass the trade data to the page
  // final Trade trade;

  const EditTradePage({super.key});

  @override
  State<EditTradePage> createState() => _EditTradePageState();
}

class _EditTradePageState extends State<EditTradePage> {
  // Create controllers for editing trade details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController modeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the trade data passed from the constructor
  }

  @override
  Widget build(BuildContext context) {
    final trade = ModalRoute.of(context)?.settings.arguments as Trade;
    nameController.text = trade.name;
    priceController.text = trade.price.toStringAsFixed(2);
    modeController.text = trade.mode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Trade'),
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
                  // Update the trade details and return to the previous screen
                  _updateTrade(trade);
                },
                child: const Text('Save Trade'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTrade(Trade trade) {
    // Get the updated values from the controllers
    final String updatedName = nameController.text;
    final double updatedPrice = double.tryParse(priceController.text) ?? 0.0;
    final String updatedMode = modeController.text;

    // Update the trade data in the original list or Provider
    // Call the updateTrade method from the provider to update the trade
    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);

    tradeProvider.updateTrade(
      trade.id, // Replace with the actual index of the trade to update
      name: updatedName,
      price: updatedPrice,
      mode: updatedMode,
    );
    // Navigate back to the previous screen
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Dispose of the controllers when the page is removed
    nameController.dispose();
    priceController.dispose();
    modeController.dispose();
    super.dispose();
  }
}
