import 'package:espresso_demo/domain/usescase/get_coins_usecase.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_event.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricingBloc extends Bloc<PricingEvent, PricingState> {
  final GetCoinsUsecase getPricing;

  PricingBloc(this.getPricing) : super(PricingInitial()) {
    on<GetPricing>(_onGetPricing);
  }

  Future<void> _onGetPricing(
    GetPricing event,
    Emitter<PricingState> emit,
  ) async {
    emit(PricingLoading());
    var pricing = await getPricing.getHistorical(
      coin: event.coin,
      currency: event.currency,
      days: event.days,
    );
    emit(PricingLoaded(pricing));
  }
}
