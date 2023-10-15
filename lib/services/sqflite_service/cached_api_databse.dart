import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // Added for JSON encoding and decoding

class CachedApiDatabase {
  CachedApiDatabase._privateConstructor();

  /// Singleton instance to access the database Globally
  /// This is the only way to access the database
  ///
  static final CachedApiDatabase instance =
      CachedApiDatabase._privateConstructor();

  /// Returns the cached data if it exists, otherwise returns null
  ///
  Future<dynamic> getCachedData(String apiUrl) async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'api_cache.db'),
      version: 1,
    );
    List<Map<String, dynamic>> maps =
        await db.query('responses', where: 'apiUrl = ?', whereArgs: [apiUrl]);

    if (maps.isNotEmpty) {
      /// Convert the JSON string to a Map object
      ///
      return jsonDecode(maps.first['responseData']);
    }

    return null;
  }

  /// Caches the response data in the database
  /// with the API URL as the primary key
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

    /// Convert the Map object to a JSON string
    String responseDataString = jsonEncode(responseData);

    await db.transaction((txn) async {
      /// Check if the table exists
      ///  If not, create the table
      bool tableExists = await _isTableExists(txn, 'responses');
      if (!tableExists) {
        await txn.execute(
          'CREATE TABLE responses(apiUrl TEXT PRIMARY KEY, responseData TEXT)',
        );
      }

      /// Insert the data into the table
      /// If the data already exists, replace it
      await txn.insert(
        'responses',
        {
          'apiUrl': apiUrl,
          'responseData': responseDataString,
        },

        /// If the data already exists, replace it
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  /// Checks if the table exists in the database
  ///  Returns true if the table exists, otherwise returns false
  Future<bool> _isTableExists(Transaction txn, String tableName) async {
    var result = await txn.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }
}
