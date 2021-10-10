part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
   NumberTriviaState([List props = const <dynamic>[]]) :super([]);
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  NumberTrivia trivia;
  Loaded({required this.trivia}) :super([trivia]);
}

class Error extends NumberTriviaState {
  final String message;
  Error({required this.message}):super([message]);
}

