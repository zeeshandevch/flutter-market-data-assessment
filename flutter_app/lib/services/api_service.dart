
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../models/market_data_model.dart';
import '../utils/constants.dart';
import 'base_api_client.dart';

class ApiService {

  Future<Either<String, List<MarketData>>> getMarketData() async {
    try {
      final response =
      await BaseApiClient.getMethod(AppConstants.marketDataEndpoint);

      final data = (response["data"] as List)
          .map((e) => MarketData.fromJson(e))
          .toList();

      return Right(data);
    } on SocketException {
      return const Left("No internet connection. Please check your network.");
    } on HttpException {
      return const Left("Something went wrong while fetching data.");
    } on FormatException {
      return const Left("Unexpected data format received from server.");
    } catch (e) {
      return const Left("Unable to load market data. Please try again later.");
    }
  }

}
