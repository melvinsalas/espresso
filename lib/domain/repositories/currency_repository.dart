import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/domain/entities/pricing.dart';

abstract class CurrencyRepository {
  Future<List<Coin>> getAllCoins(String currency);
  Future<List<Pricing>> getHistorical(
    String coin,
    String currency,
    int days,
  );
}
