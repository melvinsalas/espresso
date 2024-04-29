import 'dart:convert';

import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/domain/entities/pricing.dart';
import 'package:espresso_demo/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Coin>> getAllCurrencies(String currency);
  Future<List<Pricing>> getHistorical(String coin, String currency, int days);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Coin>> getAllCurrencies(String currency) async {
    var response = await client.get(
      Uri.parse(Constants.markerUrl(vsCurrency: currency)),
      headers: {
        'accept': 'application/json',
        'x-cg-demo-api-key': Constants.apiKey,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List<dynamic>;

      List<Coin> coins =
          data.map((coinData) => Coin.fromJson(coinData)).toList();

      return coins;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<List<Pricing>> getHistorical(
    String coin,
    String currency,
    int days,
  ) async {
    var response = await client.get(
      Uri.parse(
        Constants.historicalUrl(
          coin: coin,
          currency: currency,
          days: days,
        ),
      ),
      headers: {
        'accept': 'application/json',
        'x-cg-demo-api-key': Constants.apiKey,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var pricesData = jsonData['prices'] as List<dynamic>;

      List<Pricing> historical =
          pricesData.map((p) => Pricing.fromJson(p)).toList();

      return historical;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
