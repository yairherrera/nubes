import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'coin_details/coin_details_screen.dart';
import 'models.dart';

class CoinListItem extends StatelessWidget {
  final Coin coin;
  const CoinListItem({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool up = coin.priceChange24Percentage > 0;

    return Card(
      elevation: 4,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CoinDetailsScreen(coin: coin)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Image.network(coin.imageUrl),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.name,
                    ),
                    Text(coin.symbol),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(NumberFormat.simpleCurrency().format(coin.priceVsUsd)),
                    Text(
                      "${NumberFormat("####.##").format(coin.priceChange24Percentage)}%",
                      style: TextStyle(
                          color: up ? Colors.green : Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
