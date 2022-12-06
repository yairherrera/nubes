import 'package:crytodayapp/BNavigation/coins_list_screen.dart';
import 'package:crytodayapp/BNavigation/following_coins_screen.dart';
import 'package:crytodayapp/BNavigation/user_view.dart';
import 'package:flutter/material.dart';
import 'package:crytodayapp/BNavigation/correcion_view.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      CoinsListScreen(),
      const FollowingCoinsScreen(),
      const user_view(),
      const correcion_view()
    ];

    return myList[index];
  }
}
