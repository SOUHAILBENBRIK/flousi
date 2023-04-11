import 'package:flousi/model/money_flow.dart';
import 'package:sqflite/sqflite.dart';

class MoneyFlowDatabase {
  Database? myDatabase;
  static final MoneyFlowDatabase instance = MoneyFlowDatabase._init();

  Future<Database> get database async {
    if (myDatabase != null) return myDatabase!;
    myDatabase = await _initDB('theOne.db');
    return myDatabase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = "$dbPath/$filePath";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = " TEXT PRIMARY KEY";
    const textType = " TEXT NOT NULL";
    const doubleType = " DOUBLE NOT NULL";
    const intType = " INTEGER NOT NULL";
    const boolType = " BOOLEAN NOT NULL";
    await db.execute(
        "CREATE TABLE $tableMoneyFlow (${MoneyFlowFields.id}$idType, ${MoneyFlowFields.amount}$doubleType, ${MoneyFlowFields.createdTime}$textType, ${MoneyFlowFields.description}$textType, ${MoneyFlowFields.categoryName}$textType, ${MoneyFlowFields.categoryIconIndex}$intType, ${MoneyFlowFields.expenseOrIncome}$boolType)");
  }

  Future<MoneyFlow> create(MoneyFlow moneyFlow) async {
    final db = await instance.database;
    final id = await db.insert(tableMoneyFlow, moneyFlow.toJson());
    return moneyFlow.copy(id: id);
  }

  Future<MoneyFlow?> readOneMoneyFlow(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableMoneyFlow,
      columns: MoneyFlowFields.values,
      where: "${MoneyFlowFields.id} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MoneyFlow.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<MoneyFlow>> readSearchMoneyFlow() async {
    final db = await instance.database;

    final results =
        await db.query(tableMoneyFlow, columns: MoneyFlowFields.values);

    return results.map((json) => MoneyFlow.fromJson(json)).toList();
  }

  Future<List<MoneyFlow>> readsMoneyFlow(
      {required String date, required int expenseOrIncome}) async {
    final db = await instance.database;
    final results = await db.query(tableMoneyFlow,
        columns: MoneyFlowFields.values,
        where:
            "${MoneyFlowFields.expenseOrIncome} = ? and ${MoneyFlowFields.createdTime} = ?",
        whereArgs: [expenseOrIncome, date]);
    return results.map((json) => MoneyFlow.fromJson(json)).toList();
  }

  Future<int> update(MoneyFlow moneyFlow) async {
    final db = await instance.database;
    return db.update(tableMoneyFlow, moneyFlow.toJson(),
        where: "${MoneyFlowFields.id}=?", whereArgs: [moneyFlow.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(tableMoneyFlow,
        where: "${MoneyFlowFields.id}=?", whereArgs: [id]);
  }

  void clearDatabase() async {
    final db = await instance.database;
    // Delete the database.
    await db.delete(tableMoneyFlow);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  MoneyFlowDatabase._init();
}
