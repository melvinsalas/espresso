import 'package:equatable/equatable.dart';
import 'package:espresso_demo/domain/entities/coin.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final List<Coin> coins;

  const CoinLoaded(this.coins);

  @override
  List<Object> get props => [coins];
}
