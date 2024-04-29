import 'package:espresso_demo/data/datasources/remote_data_source.dart';
import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/domain/entities/pricing.dart';
import 'package:espresso_demo/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final RemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Coin>> getAllCoins(String currency) async {
    return await remoteDataSource.getAllCurrencies(currency);
  }

  @override
  Future<List<Pricing>> getHistorical(
    String coin,
    String currency,
    int days,
  ) async {
    return await remoteDataSource.getHistorical(coin, currency, days);
  }
}
