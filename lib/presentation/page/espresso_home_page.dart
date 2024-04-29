import 'package:espresso_demo/presentation/bloc/coin/coin_bloc.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_state.dart';
import 'package:espresso_demo/utils/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EspressoHomePage extends StatelessWidget {
  const EspressoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espresso Demo')),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoaded) {
            return ListView.builder(
              itemCount: state.coins.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/currency',
                      arguments: state.coins[index],
                    );
                  },
                  leading: Hero(
                    tag: state.coins[index].id,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(state.coins[index].image),
                      child: Text(state.coins[index].symbol[0]),
                    ),
                  ),
                  title: Text(state.coins[index].symbol),
                  subtitle: Text(state.coins[index].name),
                  trailing: Text(
                    '\$${state.coins[index].currentPrice.formatCurrency()}',
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
