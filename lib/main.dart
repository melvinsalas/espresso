import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_bloc.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_event.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_bloc.dart';
import 'package:espresso_demo/presentation/page/currency_detail_page.dart';
import 'package:espresso_demo/presentation/page/espresso_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const EspressoDemo());
}

class EspressoDemo extends StatelessWidget {
  const EspressoDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<CoinBloc>()
            ..add(
              const GetCoins(currency: 'usd'),
            ),
        ),
        BlocProvider(create: (_) => di.locator<PricingBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.teal,
        ),
        onGenerateRoute: _onGenerateRoute,
        title: 'Espresso Demo',
        home: const EspressoHomePage(),
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(settings) {
    if (settings.name == '/currency') {
      final coin = settings.arguments as Coin;
      return MaterialPageRoute(
        builder: (context) => CurrencyDetailPage(coin: coin),
      );
    }
    return null;
  }
}
