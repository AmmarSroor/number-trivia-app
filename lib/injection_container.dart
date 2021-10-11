import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:first_project/core/network/network_info.dart';
import 'package:first_project/core/util/input_converter.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:first_project/features/number_trivia/presentation/numberTriviaBloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';

final service_locator = GetIt.instance;

Future<void> init() async{
  // bloc
  service_locator.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: service_locator(),
        getRandomNumberTrivia: service_locator(),
        inputConverter: service_locator(),
      ));
  // use cases
  service_locator
      .registerLazySingleton(() => GetConcreteNumberTrivia(service_locator()));
  service_locator
      .registerLazySingleton(() => GetRandomNumberTrivia(service_locator()));

  // repository
  service_locator.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImplementation(
            remoteDataSource: service_locator(),
            localDataSource: service_locator(),
            networkInfo: service_locator(),
          ));
  //data source
  service_locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImplementation(
            client: service_locator(),
          ));

  service_locator.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImplementation(
            sharedPreferences: service_locator(),
          ));

  //Core - util
  service_locator.registerLazySingleton(() => InputConverter());
  service_locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(service_locator()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  service_locator.registerLazySingleton(() => sharedPreferences);
  service_locator.registerLazySingleton(() => http.Client());
  service_locator.registerLazySingleton(() => DataConnectionChecker());

}
