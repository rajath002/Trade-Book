import 'package:flutter/material.dart';
import 'package:flutter_new/pages/add_trade_page.dart';
import 'package:flutter_new/pages/edit_trade_page.dart';
import 'package:flutter_new/pages/trade_list_page.dart';
import 'package:flutter_new/provider/trade_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TradeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trade book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Trades'),
      // Define your page routes here
      routes: {
        '/': (context) => const TradeListPage(),
        '/add_trade': (context) => AddTradePage(),
        '/edit_trade': (context) => const EditTradePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTrade() {
    Navigator.pushNamed(context, '/add_trade');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTrade,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: const TradeListPage(),
    );
  }
}
