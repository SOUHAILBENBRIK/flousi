import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../category.dart';


class CategoryDatabase {
  Database? myDatabase;
  static final CategoryDatabase instance = CategoryDatabase._init();

  Future<Database> get database async {
    if (myDatabase != null) return myDatabase!;
    myDatabase = await _initDB('theOne.db');
    debugPrint(myDatabase!.path);
    return myDatabase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = " INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = " TEXT NOT NULL";
    const intType = " INTEGER NOT NULL";
    await db.execute("CREATE TABLE $tableCategory (${CategoryFields.id}$idType,${CategoryFields.name}$textType,${CategoryFields.icon}$intType)");
  }

  Future<Category> create(Category category) async {
    final db = await instance.database;
    final id = await db.insert(tableCategory, category.toJson());
    return category.copy(id: id);
  }

  Future<Category?> readMoneyFlow(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCategory,
      columns: CategoryFields.values,
      where: '${CategoryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Category.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Category>> readsAll() async {
    final db = await instance.database;
    final results = await db.query(
      tableCategory,
    );
    return results.map((json) => Category.fromJson(json)).toList();
  }

  Future<int> update(Category moneyFlow) async {
    final db = await instance.database;
    return db.update(tableCategory, moneyFlow.toJson(),
        where: '${CategoryFields.id}=?', whereArgs: [moneyFlow.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(tableCategory,
        where: '${CategoryFields.id}=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
    debugPrint('');
  }

  CategoryDatabase._init();
}
