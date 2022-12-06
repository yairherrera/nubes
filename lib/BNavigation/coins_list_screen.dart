import 'package:crytodayapp/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../coin_list_item.dart';
import '../models.dart';

class CoinsListScreen extends StatefulWidget {
  @override
  State<CoinsListScreen> createState() => _CoinsListScreenState();
}

class _CoinsListScreenState extends State<CoinsListScreen> {
  List<String> _defaultCoins = [
    "bitcoin",
    "ethereum",
    "solana",
    "dogecoin",
    "algorand",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>>(
      future: ApiClient().getCoins(_defaultCoins),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Coin>? coins = snapshot.data;
        if (coins == null) {
          return const Text("Error getting Coin");
        } else {
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
                  /*onFollowingCoin(context, coin.id);*/
                },
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                icon: Icons.favorite,
                label: 'Seguir'),
          ],
        ),
        child: CoinListItem(
          coin: coin,
        ));
  }

  /*void onFollowingCoin(BuildContext context, String coinId) {
    var appState = Provider.of<AppState>(context, listen: false);
    appState.add(coin.id);
  }*/
}
