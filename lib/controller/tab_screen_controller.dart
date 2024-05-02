import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:flutter/material.dart';

class TabScreenController with ChangeNotifier {
  bool isEdit;
  int tabIndex;

  TabScreenController({this.isEdit = false, this.tabIndex = 0}) {}
  final TextEditingController textAmountController = TextEditingController();

  final TextEditingController textDateController = TextEditingController();

  final TextEditingController textNoteController = TextEditingController();

  var incomeFormKey = GlobalKey<FormState>();
  var expenseFormKey = GlobalKey<FormState>();

  String? selectedDropDown;
  late String id;

  void getEditData(IncomeExpenseModel incomeExpenseModel) {
    textAmountController.text = incomeExpenseModel.amount;
    textDateController.text = incomeExpenseModel.date;
    textNoteController.text = incomeExpenseModel.note;
    selectedDropDown = incomeExpenseModel.category;
    tabIndex = incomeExpenseModel.isIncome ? 0 : 1;
    notifyListeners();
  }

  void onTabChanged() {
    selectedDropDown = null;
  }
}
