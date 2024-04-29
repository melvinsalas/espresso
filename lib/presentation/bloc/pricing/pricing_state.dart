import 'package:equatable/equatable.dart';
import 'package:espresso_demo/domain/entities/pricing.dart';

abstract class PricingState extends Equatable {
  const PricingState();

  @override
  List<Object> get props => [];
}

class PricingInitial extends PricingState {}

class PricingLoading extends PricingState {}

class PricingLoaded extends PricingState {
  final List<Pricing> price;

  const PricingLoaded(this.price);

  @override
  List<Object> get props => [price];
}
