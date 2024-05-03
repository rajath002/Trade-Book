import 'package:flutter/material.dart';
import 'package:flutter_new/provider/appwrite_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _signUp() async {
    final appWriteProvider =
        Provider.of<AppwriteProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    try {
      await appWriteProvider.createAccount(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      // Handle error
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
    if (!context.mounted) return;
    Navigator.pushNamed(context, '/list');
  }

  void _signIn() async {
    final appWriteProvider = Provider.of<AppwriteProvider>(context);
    setState(() {
      _isLoading = true;
    });

    try {
      // await appWriteProvider.signIn(_emailController.text, _passwordController.text);
    } catch (e) {
      // Handle error
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
