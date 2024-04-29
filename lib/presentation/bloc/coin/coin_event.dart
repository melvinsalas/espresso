import 'package:equatable/equatable.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

class GetCoins extends CoinEvent {
  final String currency;

  const GetCoins({this.currency = 'usd'});

  @override
  List<Object> get props => [currency];
}
