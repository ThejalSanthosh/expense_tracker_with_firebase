import 'package:expense_tracker/controller/income_expense_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeTab extends StatefulWidget {
  IncomeTab({super.key});

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  final TextEditingController textAmountController = TextEditingController();

  final TextEditingController textDateController = TextEditingController();

  final TextEditingController textNoteController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  String? selectedDropDown;

  @override
  Widget build(BuildContext context) {
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Amount"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: textAmountController,
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
                    DropdownButton(
                      value: selectedDropDown,
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
                        selectedDropDown = value;
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
                      controller: textDateController,
                      decoration: InputDecoration(
                          hintText: "Select Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onTap: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));
                        textDateController.text = selectedDate.toString();

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

                          textDateController.text = formateDate.toString();
                          // setState(() {});
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
                      controller: textNoteController,
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
                          if (formKey.currentState!.validate()) {
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
                                                amount:
                                                    textAmountController.text,
                                                category:
                                                    selectedDropDown.toString(),
                                                date: textDateController.text,
                                                note: textNoteController.text,
                                                isIncome: true);
                                        context
                                            .read<IncomeExpenseController>()
                                            .addData(incomeExpenseModel);
                                        selectedDropDown = null;
                                        textAmountController.clear();

                                        textDateController.clear();

                                        textNoteController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("NO"))
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
                            "Add Record",
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
