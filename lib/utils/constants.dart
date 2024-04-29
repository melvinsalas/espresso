class Constants {
  static String endpoint = 'https://api.coingecko.com/api/v3';
  static String apiKey = 'CG...';

  static String markerUrl({required String vsCurrency}) {
    return '$endpoint/coins/markets?vs_currency=$vsCurrency';
  }

  static String historicalUrl({
    required String coin,
    required String currency,
    required int days,
  }) {
    return '$endpoint/coins/$coin/market_chart?vs_currency=$currency&days=$days';
  }
}
