import 'package:expense_tracker/controller/home_screen_controller.dart';
import 'package:expense_tracker/controller/tab_screen_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/view/home_screen/widgets/custom_container_card.dart';
import 'package:expense_tracker/view/home_screen/widgets/cutom_listview_card.dart';
import 'package:expense_tracker/view/home_screen/widgets/dialog_edit_delete_card.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getTotalExpense();
      Provider.of<HomeController>(context, listen: false).getTotalIncome();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenState = Provider.of<HomeController>(context, listen: false);

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
                                "https://scontent-maa2-1.cdninstagram.com/v/t51.2885-19/395308835_3463668007277756_5707619813024977731_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-maa2-1.cdninstagram.com&_nc_cat=108&_nc_ohc=bkIO5Gsnha8Q7kNvgGzZCau&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfALLf9OLD--0RscSTySUQn2xXNkwBx32GRSWcJNfRl2Iw&oe=6638F182&_nc_sid=8b3546"),
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
                      Consumer<HomeController>(
                        builder: (context, homeState, _) => Text(
                          homeState.totalBalance.toStringAsFixed(2),
                          style: TextStyle(
                              color: ColorConstants.primaryWhite,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
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
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (context) =>
                                                  TabScreenController(),
                                              child: IncomeExpenseScreen()),
                                    ));
                              },
                              child: Consumer<HomeController>(
                                builder: (context, homeState, child) =>
                                    CustomContainerCard(
                                        title: "Income",
                                        amount: homeState.totalIncome,
                                        color: ColorConstants.primaryGreen),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (context) =>
                                                  TabScreenController(
                                                      tabIndex: 1),
                                              child: IncomeExpenseScreen()),
                                    ));
                              },
                              child: Consumer<HomeController>(
                                builder: (context, homeState, child) =>
                                    CustomContainerCard(
                                        title: "Expense",
                                        amount: homeState.totalExpense,
                                        color: ColorConstants.primaryRed),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
                          height: 310,
                          child: StreamBuilder(
                              stream: homeScreenState.collectionReference
                                  .orderBy("Date", descending: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Something went wrong"),
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return ListView.separated(
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DailogEditDeleteCard(
                                                title: snapshot.data!
                                                    .docs[index]["Category"],
                                                content: snapshot.data!
                                                    .docs[index]["Amount"],
                                                onPressedDelete: () {
                                                  context
                                                      .read<HomeController>()
                                                      .deleteData(snapshot
                                                          .data!.docs[index].id)
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              context));
                                                },
                                                onPressedEdit: () {
                                                  IncomeExpenseModel incomeExpenseModel =
                                                      IncomeExpenseModel(
                                                          amount: snapshot.data!
                                                                  .docs[index]
                                                              ["Amount"],
                                                          category: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["Category"],
                                                          date: snapshot.data!.docs[index]
                                                              ["Date"],
                                                          note: snapshot.data!
                                                                  .docs[index]
                                                              ["Note"],
                                                          isIncome: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["IsIncome"]);

                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                                create:
                                                                    (context) {
                                                                  var tabEdit =
                                                                      TabScreenController(
                                                                          isEdit:
                                                                              true);
                                                                  tabEdit.getEditData(
                                                                      incomeExpenseModel);
                                                                  tabEdit.id =
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id;
                                                                  return tabEdit;
                                                                },
                                                                child:
                                                                    IncomeExpenseScreen()),
                                                      ));
                                                },
                                              ),
                                            );
                                          },
                                          child: CustomListviewCard(
                                            amount: snapshot.data!.docs[index]
                                                ["Amount"],
                                            category: snapshot.data!.docs[index]
                                                ["Category"],
                                            date: snapshot
                                                .data!.docs[index]["Date"]
                                                .toString(),
                                            isIncome: snapshot.data!.docs[index]
                                                ["IsIncome"],
                                            note: snapshot.data!.docs[index]
                                                ["Note"],
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 15,
                                        ),
                                    itemCount: snapshot.data!.docs.length);
                              }),
                        )
                      ]),
                )
              ],
            )));
  }
}
