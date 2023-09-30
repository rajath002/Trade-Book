import 'package:flutter/material.dart';
import 'package:flutter_new/models/trade.dart';
import 'package:flutter_new/provider/trade_provider.dart';
import 'package:provider/provider.dart';

class TradeListPage extends StatelessWidget {
  const TradeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tradeProvider = Provider.of<TradeProvider>(context, listen: false);

    final trades = tradeProvider.trades;
    return Scaffold(
      appBar: AppBar(title: const Text('Trade List')),
      body: TradeList(
        trades: trades,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_trade'),
        tooltip: 'Add New Trade',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TradeList extends StatefulWidget {
  final List<Trade> trades;

  const TradeList({
    super.key,
    required this.trades,
  });

  @override
  State<TradeList> createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  @override
  Widget build(BuildContext context) {
    TradeProvider tradeProvider =
        Provider.of<TradeProvider>(context, listen: true);
    return ListView.builder(
      itemCount: widget.trades.length,
      itemBuilder: (BuildContext context, int index) {
        final trade = widget.trades[index];
        return Dismissible(
          key: UniqueKey(),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
          ),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              return await _showDeleteConfirmationDialog(context);
            } else {
              bool edit = await _showEditConfirmationDialog(
                context,
                widget.trades[index],
              );
              if (edit) {
                // Navigate to Edit
              }
              return false;
            }
          },
          onDismissed: (direction) {
            _deleteTrade(index, tradeProvider);
          },
          child: ListTile(
            title: Text(trade.name),
            subtitle: Text(
                'Price: \$${trade.price.toStringAsFixed(2)} - ${trade.mode}'),
            trailing: Text(
              '${trade.time.hour}:${trade.time.minute}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Trade'),
          content: const Text('Do you want to delete this trade?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showEditConfirmationDialog(
      BuildContext context, Trade trade) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Trade'),
          content: const Text('Do you want to Edit this trade?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel Edit
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm Edit
                Navigator.pushNamed(
                  context,
                  '/edit_trade',
                  arguments: trade, // Pass the trade you want to edit
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTrade(int index, TradeProvider tradeProvider) {
    setState(() {
      tradeProvider.deleteTrade(index);
    });
  }
}
