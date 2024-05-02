import 'package:expense_tracker/controller/home_screen_controller.dart';
import 'package:expense_tracker/controller/tab_screen_controller.dart';
import 'package:expense_tracker/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyClllUkJ2_B7HqULZz70SQbfy2lqmtFjPg",
          appId: "1:590859807503:android:213a1259473fbca751ac7a",
          messagingSenderId: "",
          projectId: "expensetracker-289ac",
          storageBucket: "expensetracker-289ac.appspot.com"));
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
