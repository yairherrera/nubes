class Coin {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double priceVsUsd;
  final double priceChange24Percentage;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.priceVsUsd,
    required this.priceChange24Percentage,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      imageUrl: json['image']['large'],
      priceVsUsd: json['market_data']['current_price']['usd'].toDouble(),
      priceChange24Percentage:
          json['market_data']['price_change_percentage_24h'].toDouble(),
    );
  }
}

class CoinMarketInfo {
  final int marketCapRank;
  final double marketCap;
  final double tradingVolume24H;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;

  CoinMarketInfo({
    required this.marketCapRank,
    required this.marketCap,
    required this.tradingVolume24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
  });

  factory CoinMarketInfo.fromJson(Map<String, dynamic> json) {
    return CoinMarketInfo(
      marketCap: getJsonFieldSafe<double>(
          json['market_data']['market_cap'], 'usd', 0.0),
      marketCapRank:
          getJsonFieldSafe<int>(json['market_data'], 'market_cap_rank', 0),
      tradingVolume24H: getJsonFieldSafe<double>(
          json['market_data']['total_volume'], 'usd', 0.0),
      circulatingSupply: getJsonFieldSafe<double>(
          json['market_data'], 'circulating_supply', 0.0),
      totalSupply:
          getJsonFieldSafe<double>(json['market_data'], 'total_supply', 0.0),
      maxSupply:
          getJsonFieldSafe<double>(json['market_data'], 'max_supply', 0.0),
    );
  }
}

T getJsonFieldSafe<T>(Map<String, dynamic> json, String field, T defaultValue) {
  try {
    dynamic value = json[field];
    Type type = value.runtimeType;
    if (type == int && T == double) {
      int casted = value as int;
      return tryCast(casted.toDouble(), defaultValue);
    } else {
      return tryCast(value, defaultValue);
    }
  } catch (e) {
    print(e);
    return defaultValue;
  }
}

T tryCast<T>(dynamic x, T fallback) {
  try {
    return (x as T);
  } on TypeError catch (e) {
    print('TypeError when trying to cast $x to $T!, e: $e');
    return fallback;
  }
}

class MarketChart {
  final List<PricePoint> prices;
  final double maxPrice;
  final double minPrice;

  MarketChart(this.prices, this.maxPrice, this.minPrice);

  factory MarketChart.fromJson(Map<String, dynamic> json) {
    List<PricePoint> prices = [];
    for (var element in json['prices']) {
      prices.add(PricePoint(element[1].toDouble(), element[0].toDouble()));
    }
    double maxPrice = prices
        .reduce((curr, next) => curr.price > next.price ? curr : next)
        .price;
    double minPrice = prices
        .reduce((curr, next) => curr.price < next.price ? curr : next)
        .price;

    return MarketChart(prices, maxPrice, minPrice);
  }
}

class PricePoint {
  final double price;
  final double timestamp;

  PricePoint(this.price, this.timestamp);
}
