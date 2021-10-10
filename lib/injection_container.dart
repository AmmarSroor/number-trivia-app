
import 'package:first_project/features/number_trivia/presentation/numberTriviaBloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init(){
  // bloc 
  sl.registerFactory(() => NumberTriviaBloc(getConcreteNumberTrivia: getConcreteNumberTrivia, getRandomNumberTrivia: getRandomNumberTrivia, inputConverter: inputConverter));
}