import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;

  List<MarketData> get marketData => _marketData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMarketData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    Either<String, List<MarketData>> response =
        await _apiService.getMarketData();

    response.fold(
      (error) {
        _error = error;
      },
      (data) async {
        _marketData = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
