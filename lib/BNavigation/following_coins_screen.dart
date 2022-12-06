import 'package:crytodayapp/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../coin_list_item.dart';
import '../models.dart';

class FollowingCoinsScreen extends StatelessWidget {
  const FollowingCoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, appState, Widget? child) {
        return FutureBuilder<List<Coin>>(
          future: getFollowedCoins(appState),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Coin>? coins = snapshot.data;
            if (coins == null) {
              return const Text("Error getting Coin");
            } else {
              if (coins.isEmpty) {
                return const Center(
                    child: Text("Aun no estás siguiendo ninguna moneda."));
              }
              return ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  return CoinRow(
                    coin: coins[index],
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  Future<List<Coin>> getFollowedCoins(AppState appState) async {
    var coinsIds = appState.followedCoinsIds;
    return ApiClient().getCoins(coinsIds);
  }
}

class CoinRow extends StatelessWidget {
  final Coin coin;

  const CoinRow({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
                onPressed: (context) {
                  /*onUnfollowingCoin(context, coin.id);*/
                },
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                icon: Icons.favorite,
                label: 'No seguir'),
          ],
        ),
        child: CoinListItem(
          coin: coin,
        ));
  }

  /*void onUnfollowingCoin(BuildContext context, String coinId) {
    var appState = Provider.of<AppState>(context, listen: false);
    appState.remove(coinId);
  }*/
}
