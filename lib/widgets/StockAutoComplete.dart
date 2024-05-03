import 'package:flutter/material.dart';

import '../models/Stock.dart';

List<Stock> stocks = [
  Stock(name: "Apple Inc.", code: "AAPL"),
  Stock(name: "Amazon.com Inc.", code: "AMZN"),
  Stock(name: "Alphabet Inc. (Google)", code: "GOOGL"),
  Stock(name: "Microsoft Corporation", code: "MSFT"),
  Stock(name: "Tesla, Inc.", code: "TSLA"),
  Stock(name: "Facebook, Inc.", code: "FB"),
  Stock(name: "Johnson & Johnson", code: "JNJ"),
  Stock(name: "Visa Inc.", code: "V"),
  Stock(name: "Walmart Inc.", code: "WMT"),
  Stock(name: "Procter & Gamble Co.", code: "PG"),
];

class StockAutoComplete extends StatefulWidget {
  final String initialValue = '';
  final Function(String) callback;
  final String? labelText;

  const StockAutoComplete(
      {required initialValue, required this.callback, this.labelText = '', key})
      : super(key: key);

  static String _displayStringForOption(Stock option) =>
      "${option.name} - ${option.code}";

  @override
  State<StockAutoComplete> createState() => _StockAutoCompleteState();
}

class _StockAutoCompleteState extends State<StockAutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Stock>(
        displayStringForOption: StockAutoComplete._displayStringForOption,
        initialValue: TextEditingValue(text: widget.initialValue),
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextFormField(
                  decoration: InputDecoration(labelText: widget.labelText),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onEditingComplete: onFieldSubmitted,
                ),
        optionsBuilder: (TextEditingValue textEditingValue) {
          // Filter the suggestions based on the user's input
          if (textEditingValue.text == '') {
            return const Iterable<Stock>.empty();
          }
          return stocks.where((Stock option) {
            return "${option.name} ${option.code}"
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (Stock selection) {
          // Handle the selected suggestion
          widget.callback(StockAutoComplete._displayStringForOption(selection));
        });
  }
}
