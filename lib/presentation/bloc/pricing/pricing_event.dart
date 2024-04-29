import 'package:equatable/equatable.dart';

abstract class PricingEvent extends Equatable {
  const PricingEvent();

  @override
  List<Object> get props => [];
}

class GetPricing extends PricingEvent {
  final String coin;
  final String currency;
  final int days;

  const GetPricing({required this.coin, this.currency = 'usd', this.days = 90});

  @override
  List<Object> get props => [coin, currency, days];
}
