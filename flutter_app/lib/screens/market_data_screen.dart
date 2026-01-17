import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/market_data_model.dart';
import '../providers/market_data_provider.dart';
import '../utils/constants.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarketDataProvider>().loadMarketData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}'),
                ElevatedButton(
                  onPressed: () => provider.loadMarketData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.marketData.isEmpty) {
          return const Center(
            child: Text(
              'No market data available',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.loadMarketData,
          child: ListView.builder(
            itemCount: provider.marketData.length,
            itemBuilder: (context, index) {
              final MarketData item = provider.marketData[index];
              final bool isPositive = item.changePercent24h >= 0;
              final String sign = isPositive ? '+' : '';

              return ListTile(
                title: Text(item.symbol),
                subtitle: Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  '$sign${item.changePercent24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: Color(
                      isPositive
                          ? AppConstants.positiveColor
                          : AppConstants.negativeColor,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
