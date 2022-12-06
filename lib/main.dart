import 'package:crytodayapp/BNavigation/bottom_nav.dart';
import 'package:crytodayapp/BNavigation/routes.dart';
import 'package:crytodayapp/app_preferences.dart';
import 'package:crytodayapp/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BNavigation/coins_list_screen.dart';
import 'BNavigation/following_coins_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        title: 'Crypto Owl',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  BNavigator? myBNB;

  @override
  initState() {
    myBNB = BNavigator(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/owl_icon.png",
            width: 30,
          ),
          Padding(padding: EdgeInsets.only(right: 5, left: 5)),
          Text(
            "Crypto Owl",
            style: TextStyle(color: Colors.black87),
          )
        ]),
      ),
      body: Routes(index: index),
      bottomNavigationBar: myBNB,
    );
  }
}
