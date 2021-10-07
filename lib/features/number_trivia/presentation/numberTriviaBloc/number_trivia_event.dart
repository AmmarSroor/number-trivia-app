part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent([List props =const<dynamic> []]) : super(props);
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent{
  final String inputNumberTrivia;

  GetConcreteNumberTriviaEvent(this.inputNumberTrivia);
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent{}
