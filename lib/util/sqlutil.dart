import 'package:crowdate/model/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLUtil {
  static Future<void> putFavorite(EventModel model) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), "events.db"),
      version: 1,
    );

    Map<String, dynamic> json = model.toJson();
    json.addAll({
      "id": model.id
    });
    await database.insert("events", json, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeFavorite(EventModel model) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), "events.db"),
      version: 1,
    );

    await database.delete("events", where: "id = ?", whereArgs: [model.id]);
  }
}
