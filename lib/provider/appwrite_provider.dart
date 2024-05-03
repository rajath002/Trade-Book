import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppwriteProvider extends ChangeNotifier {
  final Client client;
  late Account account;

  final _endPoint = dotenv.env['AW_ENDPOINT'];
  final _project = dotenv.env['AW_PROJECT'];
  final _databaseId = dotenv.env['AW_DATABASE_ID'];
  final _collectionId = dotenv.env['AW_COLLECTION_ID'];

  AppwriteProvider(this.client);

  _init() {
    client.setEndpoint(_endPoint!).setProject(_project).setSelfSigned(
          status: true,
        );
    account = Account(client);
  }

  Future<void> createAccount(String email, String password) async {
    try {
      _init();
      // For self signed certificates, only use for development
      // Generate a random userId
      final userId = ID.unique();
      // Create a new user with the generated userId
      final user = account.create(
        userId: userId,
        email: email,
        password: password,
      );
      print(user);
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

  @override
  void dispose() {
    super.dispose();
  }
}
