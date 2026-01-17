// TODO: Create MarketData model class
// Required fields:
// - symbol (String)
// - price (double)
// - change24h (double)
// - changePercent24h (double)
// - volume (double)
//
// Add a factory constructor fromJson that parses the JSON response
// Example JSON structure from API:
// {
//   "symbol": "BTC/USD",
//   "price": 43250.50,
//   "change24h": 2.5,
//   "changePercent24h": 2.5,
//   "volume": 1250000000
// }

class MarketData {
  final String symbol;
  final double price;
  final double change24h;
  final double changePercent24h;

  const MarketData({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      symbol: json['symbol'] ?? "",
      price: json['price'] ?? 0.0,
      change24h: json['change24h'] ?? 0.0,
      changePercent24h: json['changePercent24h'] ?? 0.0,
    );
  }
}

