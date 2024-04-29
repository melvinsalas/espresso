import 'package:espresso_demo/domain/usescase/get_coins_usecase.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_event.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final GetCoinsUsecase getCurrencies;

  CoinBloc(this.getCurrencies) : super(CoinInitial()) {
    on<GetCoins>(_onGetCurrencies);
  }

  Future<void> _onGetCurrencies(
    GetCoins event,
    Emitter<CoinState> emit,
  ) async {
    emit(CoinLoading());
    var currencies = await getCurrencies.getAllCoins(event.currency);
    emit(CoinLoaded(currencies));
  }
}
