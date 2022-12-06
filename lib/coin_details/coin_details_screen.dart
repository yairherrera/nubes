import 'package:crytodayapp/api_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models.dart';
import 'coin_market_chart.dart';

class CoinDetailsScreen extends StatelessWidget {
  final Coin coin;
  const CoinDetailsScreen({required this.coin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.simpleCurrency();
    bool increased = coin.priceChange24Percentage > 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              coin.imageUrl,
              width: 40,
            ),
            const Padding(padding: EdgeInsets.only(right: 3, left: 3)),
            Text(
              coin.symbol.toUpperCase(),
              style: const TextStyle(color: Colors.black87),
            ),
            const Padding(padding: EdgeInsets.only(right: 60)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              coin.name,
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Text(
                  "USD${currencyFormatter.format(coin.priceVsUsd)}",
                  style: TextStyle(fontSize: 25),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: increased ? Colors.green : Colors.red,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        increased
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      Text(
                        "${NumberFormat("####.##").format(coin.priceChange24Percentage)}%",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 14)),
            CoinMarketChart(coinId: coin.id),
            Padding(padding: EdgeInsets.only(bottom: 14)),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45,
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.white),
                child: MarketInfoRows(coin.id, currencyFormatter),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MarketInfoRows extends StatelessWidget {
  final String coinId;
  final NumberFormat currencyFormatter;
  MarketInfoRows(this.coinId, this.currencyFormatter);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CoinMarketInfo>(
        future: ApiClient().getCoinMarketInfo(coinId),
        builder: (context, snapshot) {
          List<Widget> rows = [];
          if (snapshot.hasData) {
            CoinMarketInfo? coinInfo = snapshot.data;
            if (coinInfo != null) {
              List<MarketField> marketFields = [
                MarketField("Market cap rank", "#${coinInfo.marketCapRank}"),
                MarketField(
                    "Market cap", currencyFormatter.format(coinInfo.marketCap)),
                MarketField("Trading volume",
                    currencyFormatter.format(coinInfo.tradingVolume24H)),
                MarketField("Circulating supply",
                    currencyFormatter.format(coinInfo.circulatingSupply)),
                MarketField("Total supply",
                    currencyFormatter.format(coinInfo.totalSupply)),
                MarketField(
                    "Max supply", currencyFormatter.format(coinInfo.maxSupply)),
              ];
              marketFields.asMap().forEach((index, mf) {
                var row = Row(
                  children: [Text(mf.field), const Spacer(), Text(mf.value)],
                );
                rows.add(row);
                if (index < marketFields.length - 1) {
                  rows.add(const Divider(
                    color: Colors.black12,
                  ));
                }
              });
            }
          } else {
            rows.add(const CircularProgressIndicator());
          }
          return Column(
            children: rows,
          );
        });
  }
}

class MarketField {
  final String field;
  final String value;

  MarketField(this.field, this.value);
}
