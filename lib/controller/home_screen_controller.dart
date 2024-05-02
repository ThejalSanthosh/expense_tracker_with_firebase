import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("income_expense");

  double totalIncome = 0;
  double totalExpense = 0;
  double totalBalance = 0;


  Future addData(IncomeExpenseModel incomeExpenseModel) async {
    final data = {
      "Amount": incomeExpenseModel.amount,
      "Category": incomeExpenseModel.category,
      "Date": incomeExpenseModel.date,
      "IsIncome": incomeExpenseModel.isIncome,
      "Note": incomeExpenseModel.note
    };

    await collectionReference.add(data);
    getTotalIncome();
    getTotalExpense();
    notifyListeners();
  }

  Future editData(String id, IncomeExpenseModel incomeExpenseModel) async {
    final data = {
      "Amount": incomeExpenseModel.amount,
      "Category": incomeExpenseModel.category,
      "Date": incomeExpenseModel.date,
      "IsIncome": incomeExpenseModel.isIncome,
      "Note": incomeExpenseModel.note
    };

    await collectionReference.doc(id).set(data);
    getTotalIncome();
    getTotalExpense();
  }

  Future deleteData(String id) async {
    try {
      await collectionReference.doc(id).delete();
      getTotalIncome();
      getTotalExpense();

    } catch (e) {
      e.toString();
    }
  }

  Future getTotalIncome() async {
    try {
      QuerySnapshot snapshot =
          await collectionReference.where("IsIncome", isEqualTo: true).get();
      totalIncome = 0;
      snapshot.docs.forEach((element) {
        totalIncome += double.parse(element["Amount"]);
      });
      totalBalance = totalIncome - totalExpense;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getTotalExpense() async {
    try {
      QuerySnapshot snapshot =
          await collectionReference.where("IsIncome", isEqualTo: false).get();
      totalExpense = 0;
      snapshot.docs.forEach((element) {
        totalExpense += double.parse(element["Amount"]);
      });
      totalBalance = totalIncome - totalExpense;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
