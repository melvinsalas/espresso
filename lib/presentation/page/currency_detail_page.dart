import 'package:espresso_demo/domain/entities/coin.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_bloc.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_event.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_state.dart';
import 'package:espresso_demo/presentation/widgets/convesor_widget.dart';
import 'package:espresso_demo/presentation/widgets/pricing_chart_widget.dart';
import 'package:espresso_demo/utils/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyDetailPage extends StatefulWidget {
  final Coin coin;

  const CurrencyDetailPage({super.key, required this.coin});

  @override
  State<CurrencyDetailPage> createState() => _CurrencyDetailPageState();
}

class _CurrencyDetailPageState extends State<CurrencyDetailPage> {
  @override
  void initState() {
    context.read<PricingBloc>().add(GetPricing(coin: widget.coin.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.coin.name)),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: true,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Hero(
                        tag: widget.coin.id,
                        child: Image.network(widget.coin.image),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${widget.coin.name}'),
                        Text('Symbol: ${widget.coin.symbol}'),
                        Text(
                            'Current Price: \$${widget.coin.currentPrice.formatCurrency()}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Conversor(
                    coin: widget.coin.name, price: widget.coin.currentPrice),
                const SizedBox(height: 10),
                BlocBuilder<PricingBloc, PricingState>(
                  builder: (context, state) {
                    if (state is PricingLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historical Price',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          PricingChartWidget(price: state.price),
                        ],
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
