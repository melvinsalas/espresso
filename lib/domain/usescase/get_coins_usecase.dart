import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/domain/entities/pricing.dart';
import 'package:espresso_demo/domain/repositories/currency_repository.dart';

class GetCoinsUsecase {
  final CurrencyRepository repository;

  GetCoinsUsecase(this.repository);

  Future<List<Coin>> getAllCoins(String currency) async {
    return await repository.getAllCoins(currency);
  }

  Future<List<Pricing>> getHistorical({
    required String coin,
    required String currency,
    required int days,
  }) async {
    return await repository.getHistorical(coin, currency, days);
  }
}
