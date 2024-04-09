import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomListviewCard extends StatelessWidget {
  const CustomListviewCard(
      {super.key,
      required this.category,
      required this.amount,
      required this.note,
      required this.date,
      required this.isIncome});

  final String category;
  final String amount;
  final String note;
  final String date;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            isIncome == true
                ? CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        ColorConstants.primaryGreen.withOpacity(.3),
                    child: Icon(
                      Icons.arrow_upward,
                      size: 11,
                      color: ColorConstants.primaryGreen,
                    ))
                : CircleAvatar(
                    radius: 12,
                    backgroundColor: ColorConstants.primaryRed.withOpacity(.3),
                    child: Icon(
                      Icons.arrow_downward,
                      size: 11,
                      color: ColorConstants.primaryRed,
                    )),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                      color: ColorConstants.primaryBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  note,
                  style: TextStyle(
                      color: ColorConstants.primaryBlack,
                      fontSize: 11,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isIncome == true ? "+\$$amount" : "-\$$amount",
                  style: TextStyle(
                      color: ColorConstants.primaryBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: ColorConstants.primaryBlack,
                      fontSize: 11,
                      fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
