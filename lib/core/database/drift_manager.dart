/* import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;

class Database {
  LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app.db'));

      if (!await file.exists()) {
        // Extract the pre-populated database file from assets
        final blob = await rootBundle.load('assets/my_database.db');
        final buffer = blob.buffer;
        await file.writeAsBytes(
            buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
      }

      return NativeDatabase(file);
    });
  }
}
 */