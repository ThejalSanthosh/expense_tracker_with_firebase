import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DailogEditDeleteCard extends StatelessWidget {
  DailogEditDeleteCard(
      {super.key,
      required this.title,
      required this.content,
      this.onPressedEdit,
      this.onPressedDelete});

  final String title;
  final String content;
  final void Function()? onPressedEdit;

  final void Function()? onPressedDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    
      title: Text(
        title,
        style: TextStyle(
            color: ColorConstants.primaryBlack, fontWeight: FontWeight.w800),
      ),
      content: Text(
        content,
        style: TextStyle(
            color: ColorConstants.primaryBlack,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      actions: [
        IconButton(
            onPressed: onPressedEdit,
            icon: Icon(
              Icons.edit,
              color: ColorConstants.primaryGreen,
            )),
        IconButton(
            onPressed:  onPressedDelete,
            icon: Icon(
              Icons.delete,
              color: ColorConstants.primaryRed,
            ))
      ],
    );
  }
}
