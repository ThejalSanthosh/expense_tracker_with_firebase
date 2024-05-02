import 'package:expense_tracker/controller/home_screen_controller.dart';
import 'package:expense_tracker/controller/tab_screen_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeTab extends StatefulWidget {
  IncomeTab({
    super.key,
  });

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  @override
  Widget build(BuildContext context) {
    final tabScreenState = Provider.of<TabScreenController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Material(
          elevation: 7,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                key: tabScreenState.incomeFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Amount"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tabScreenState.textAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter Amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Category"),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      value: tabScreenState.selectedDropDown,
                      hint: Text("Select"),
                      isExpanded: true,
                      style: TextStyle(color: ColorConstants.primaryBlack),
                      elevation: 10,
                      items: [
                        DropdownMenuItem(
                          child: Text("Salary"),
                          value: "Salary",
                        ),
                        DropdownMenuItem(
                          child: Text("Trading"),
                          value: "Trading",
                        )
                      ],
                      onChanged: (value) {
                        tabScreenState.selectedDropDown = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Date"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: tabScreenState.textDateController,
                      decoration: InputDecoration(
                          hintText: "Select Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onTap: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));
                        tabScreenState.textDateController.text =
                            selectedDate.toString();

                        if (selectedDate != null) {
                          final selectedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (selectedTime != null) {
                            selectedDate = selectedDate.add(Duration(
                                hours: selectedTime.hour,
                                minutes: selectedTime.minute));
                          }
                          String formateDate = DateFormat("dd-MMM-yyyy hh:mm a")
                              .format(selectedDate);

                          tabScreenState.textDateController.text =
                              formateDate.toString();
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Note"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tabScreenState.textNoteController,
                      decoration: InputDecoration(
                          hintText: "Enter Note",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter note';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (tabScreenState.incomeFormKey.currentState!
                              .validate()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  "Income Details Added Successfully",
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        IncomeExpenseModel incomeExpenseModel =
                                            IncomeExpenseModel(
                                                amount: tabScreenState
                                                    .textAmountController.text,
                                                category: tabScreenState
                                                    .selectedDropDown
                                                    .toString(),
                                                date: tabScreenState
                                                    .textDateController.text,
                                                note: tabScreenState
                                                    .textNoteController.text,
                                                isIncome: true);
                                        tabScreenState.isEdit == false
                                            ? context
                                                .read<HomeController>()
                                                .addData(incomeExpenseModel)
                                            : context
                                                .read<HomeController>()
                                                .editData(tabScreenState.id,
                                                    incomeExpenseModel);

                                        tabScreenState.selectedDropDown = null;
                                        tabScreenState.textAmountController
                                            .clear();

                                        tabScreenState.textDateController
                                            .clear();

                                        tabScreenState.textNoteController
                                            .clear();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ));
                                      },
                                      child: Text("OK")),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 70),
                          child: Text(
                            tabScreenState.isEdit == false
                                ? "Add Record"
                                : "Edit Record",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
