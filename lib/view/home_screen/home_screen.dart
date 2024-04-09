import 'package:expense_tracker/controller/income_expense_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/home_screen/widgets/custom_container_card.dart';
import 'package:expense_tracker/view/home_screen/widgets/cutom_listview_card.dart';
import 'package:expense_tracker/view/income_expense_screen/income_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<IncomeExpenseController>(context, listen: false).getData();
    Provider.of<IncomeExpenseController>(context, listen: false)
        .totalIncomeSum();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.primaryWhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                  color: ColorConstants.primaryBlack,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://instagram.fcok4-1.fna.fbcdn.net/v/t51.2885-19/395308835_3463668007277756_5707619813024977731_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fcok4-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=EX4gXXAtI40Ab4dB-My&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBYszPTsHXgykaGbhrTsjnMEfmgHC6KMhJU3c6aia5o5w&oe=6616E2C2&_nc_sid=8b3546"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "Hello Thejal",
                            style: TextStyle(
                                color: ColorConstants.primaryWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                                color: ColorConstants.primaryWhite,
                                fontWeight: FontWeight.normal,
                                fontSize: 10),
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.menu,
                        color: ColorConstants.primaryWhite,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Balance",
                    style: TextStyle(color: ColorConstants.primaryWhite),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "\$243",
                    style: TextStyle(
                        color: ColorConstants.primaryWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IncomeExpenseScreen(),
                                ));
                          },
                          child: Consumer<IncomeExpenseController>(
                            builder: (context, value, child) =>
                                CustomContainerCard(
                                    title: "Income",
                                    amount: "\$${value.incomeAmount}",
                                    color: ColorConstants.primaryGreen),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomContainerCard(
                            title: "Expense",
                            amount: "\$444",
                            color: ColorConstants.primaryRed),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Transcations",
                      style: TextStyle(
                          color: ColorConstants.primaryBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 350,
                      child: Consumer<IncomeExpenseController>(
                        builder: (context, value, child) =>  ListView.separated(
                            itemBuilder: (context, index) => CustomListviewCard(
                                category: IncomeExpenseController
                                    .lstIncomeExpenseModelData[index].category,
                                amount: IncomeExpenseController
                                    .lstIncomeExpenseModelData[index].amount,
                                note: IncomeExpenseController
                                    .lstIncomeExpenseModelData[index].note,
                                date: IncomeExpenseController
                                    .lstIncomeExpenseModelData[index].date,
                                isIncome: IncomeExpenseController
                                    .lstIncomeExpenseModelData[index].isIncome),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: IncomeExpenseController
                                .lstIncomeExpenseModelData.length),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
