import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomContainerCard extends StatelessWidget {
  const CustomContainerCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.color});

  final String title;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 150,
            height: 120,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
     color: ColorConstants.primaryWhite,
     borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
     CircleAvatar(
         backgroundColor: color.withOpacity(0.3),
         radius: 12,
         child: Icon(
           title == "Income" ? Icons.arrow_upward : Icons.arrow_downward,
           size: 11,
           color: color,
         )),
     SizedBox(
       width: 10,
     ),
     Expanded(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             title,
             style: TextStyle(
               color: ColorConstants.primaryGreen,
             ),
           ),
           SizedBox(
             height: 2,
           ),
           Text(
             amount.toStringAsFixed(2),
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
                 color: ColorConstants.primaryBlack,
                 fontSize: 18,
                 fontWeight: FontWeight.bold),
           )
         ],
       ),
     )
              ],
            ),
          );
  }
}
