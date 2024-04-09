import 'dart:developer';

import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class IncomeExpenseController with ChangeNotifier {
  static late Database database;
  static List<Map<String, Object?>> lstData = [];
  static List<IncomeExpenseModel> lstIncomeExpenseModelData = [];
  var incomeAmount;

  static Future<void> initDb() async {
    database = await openDatabase("tracker.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE RecordTracker (id INTEGER PRIMARY KEY, Amount TEXT, Category TEXT, Date TEXT, Note TEXT,IsIncome BIT)');
    });
  }
  // function to add new data to db

  Future<void> addData(IncomeExpenseModel incomeExpenseModel) async {
    await database.rawInsert(
        'INSERT INTO RecordTracker(Amount, Category, Date, Note, IsIncome) VALUES(?, ?, ?, ?, ?)',
        [
          incomeExpenseModel.amount,
          incomeExpenseModel.category,
          incomeExpenseModel.date,
          incomeExpenseModel.note,
          incomeExpenseModel.isIncome
        ]);
    await getData();
    notifyListeners();
  }

// to get data from db

  Future<void> getData() async {
    lstData = await database
        .rawQuery('SELECT * FROM RecordTracker ORDER BY Date DESC');
    lstIncomeExpenseModelData = lstData
        .map((e) => IncomeExpenseModel(
            amount: e["Amount"].toString(),
            category: e["Category"].toString(),
            date: e["Date"].toString(),
            note: e["Note"].toString(),
            isIncome: e["IsIncome"].toString() == "1" ? true : false))
        .toList();

    // log(lstData.toString());

    notifyListeners();
  }

  Future totalIncomeSum() async {
    incomeAmount = (await database.rawQuery(
            "SELECT SUM(amount) FROM RecordTracker WHERE IsIncome = 1"))[0]
        ['SUM(amount)'];
    notifyListeners();
    log(incomeAmount.toString());
  }
}
