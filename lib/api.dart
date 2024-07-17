import 'package:appwrite/appwrite.dart';
import 'dart:developer';

import 'package:appwrite/models.dart';

class AppWrite {
  static final _client = Client();
  static final _database = Databases(_client);

  static void init() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('669781700013250e1a5e')
        .setSelfSigned(status: true);
    getMusic();
  }

  static Future<List<Document>?> getMusic() async {
    try {
      final response = await _database.listDocuments(
        databaseId: "669782ce002063e816c4",
        collectionId: "669782fe0008903412c1",
      );
      log(response.documents[0].toString());
      return response.documents;
    } catch (e) {
      log('$e');
    }
  }
}
