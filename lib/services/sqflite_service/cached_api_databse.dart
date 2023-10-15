import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // Added for JSON encoding and decoding

class CachedApiDatabase {
  CachedApiDatabase._privateConstructor();
  static final CachedApiDatabase instance = CachedApiDatabase._privateConstructor();
  Future<dynamic> getCachedData(String apiUrl) async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'api_cache.db'),
      version: 1,
    );
    List<Map<String, dynamic>> maps =
    await db.query('responses', where: 'apiUrl = ?', whereArgs: [apiUrl]);

    if (maps.isNotEmpty) {
      // Parse the stored JSON string to dynamic
      return jsonDecode(maps.first['responseData']);
    }

    return null;
  }

  Future<void> cacheResponse(String apiUrl, dynamic responseData) async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'api_cache.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE responses(apiUrl TEXT PRIMARY KEY, responseData TEXT)',
        );
      },
      version: 1,
    );

    // Convert JSON data to a string before storing
    String responseDataString = jsonEncode(responseData);

    await db.transaction((txn) async {
      // Check if the table exists, if not, create it
      bool tableExists = await _isTableExists(txn, 'responses');
      if (!tableExists) {
        await txn.execute(
          'CREATE TABLE responses(apiUrl TEXT PRIMARY KEY, responseData TEXT)',
        );
      }

      await txn.insert(
        'responses',
        {
          'apiUrl': apiUrl,
          'responseData': responseDataString,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<bool> _isTableExists(Transaction txn, String tableName) async {
    var result = await txn.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );

    return result.isNotEmpty;
  }
}
