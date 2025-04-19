import 'package:idb_shim/idb_browser.dart';

import '../models/log_entry.dart';

class LocalDatabase {
  static const _dbName = 'logs_db';
  static const _storeName = 'logs';

  late final Database _db;

  Future<void> init() async {
    _db = await idbFactoryBrowser.open(_dbName, version: 1, onUpgradeNeeded: (e) {
      e.database.createObjectStore(_storeName, autoIncrement: true);
    });
  }

  Future<void> insertLog(LogEntry entry) async {
    final txn = _db.transaction(_storeName, 'readwrite');
    final store = txn.objectStore(_storeName);
    await store.add(entry.toJson());
    await txn.completed;
  }
  Future<List<dynamic>> getAllLogs() async {
    final txn = _db.transaction(_storeName, 'readwrite');
    final store = txn.objectStore(_storeName);
    return store.getAll() as List<LogEntry>;
  }
}
