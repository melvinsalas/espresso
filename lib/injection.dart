import 'package:espresso_demo/data/datasources/remote_data_source.dart';
import 'package:espresso_demo/data/repositories/currency_repository_impl.dart';
import 'package:espresso_demo/domain/repositories/currency_repository.dart';
import 'package:espresso_demo/domain/usescase/get_coins_usecase.dart';
import 'package:espresso_demo/presentation/bloc/coin/coin_bloc.dart';
import 'package:espresso_demo/presentation/bloc/pricing/pricing_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => CoinBloc(locator()));
  locator.registerFactory(() => PricingBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCoinsUsecase(locator()));

  // repository
  locator.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(remoteDataSource: locator()),
  );

  // datasource
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
