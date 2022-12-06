import 'dart:convert';

import 'package:crytodayapp/coin_details/coin_market_chart.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class ApiClient {
  static const baseUrl = "https://api.coingecko.com/api/v3/";

  Future<Coin> getCoin(String coinId, {bool localization = false}) async {
    final response = await http.get(Uri.parse(
        "${baseUrl}coins/$coinId?localization=$localization&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false"));

    if (response.statusCode == 200) {
      return Coin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error getting Coin");
    }
  }

  Future<MarketChart> getCoinMarketChartInfo(String coinId) async {
    String days = "30";
    String interval = "daily";

    final response = await http.get(Uri.parse(
        "$baseUrl/coins/$coinId/market_chart?vs_currency=usd&days=$days&interval=$interval"));
    if (response.statusCode == 200) {
      return MarketChart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error getting Coin");
    }
  }

  Future<CoinMarketInfo> getCoinMarketInfo(String coinId) async {
    final response = await http.get(Uri.parse(
        "${baseUrl}coins/$coinId?localization=false&tickers=false&market_data=true&community_data=true&developer_data=true&sparkline=false"));

    if (response.statusCode == 200) {
      return CoinMarketInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error getting Coin");
    }
  }

  Future<List<Coin>> getCoins(List<String> coinsIds) async {
    List<Coin> coins = [];

    for (String id in coinsIds) {
      coins.add(await getCoin(id));
    }

    return coins;
  }
}
