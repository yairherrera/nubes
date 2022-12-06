import 'package:flutter/material.dart';

import 'app_preferences.dart';

class AppState extends ChangeNotifier {
  List<String> _followedCoinsIds = [];

  List<String> get followedCoinsIds => _followedCoinsIds;

  set followedCoinsIds(List<String> coinsIds) {
    _followedCoinsIds = coinsIds;
    notifyListeners();
  }

  /*void add(String coinId) {
    _followedCoinsIds.add(coinId);
    notifyListeners();
    AppPreferences().saveFollowedCoin(coinId);
  }

  void remove(String coinId) {
    _followedCoinsIds.remove(coinId);
    notifyListeners();
    AppPreferences().deleteFollowedCoin(coinId);
  }*/
}
