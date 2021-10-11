part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent{
  final String inputNumberTrivia;

  GetConcreteNumberTriviaEvent(this.inputNumberTrivia);

  @override
  List<Object?> get props => [inputNumberTrivia];
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent{

}
