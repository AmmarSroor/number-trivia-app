import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_project/core/util/input_converter.dart';
import 'package:first_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input Message';
const String SERVER_FAILURE_MESSAGE = 'Invalid Server Message';
const String CACHE_FAILURE_MESSAGE = 'Invalid Cache Message';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia? getConcreteNumberTrivia;
  final GetRandomNumberTrivia? getRandomNumberTrivia;
  final InputConverter? inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  });

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if(event is GetConcreteNumberTriviaEvent){
      final inputEither = inputConverter!.convertStringToInteger(event.inputNumberTrivia);

      yield* inputEither.fold(
        (failure) async*{
          yield Error(message:INVALID_INPUT_FAILURE_MESSAGE );
        },
        (number) => throw UnimplementedError(),
      );
    }
  }
}
