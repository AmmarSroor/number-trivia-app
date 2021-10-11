import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  Failure([List properties = const<dynamic>[]]);
  @override
  List<Object?> get props => [];
}

// these are general failures
class ServerFailure extends Failure{}

class CacheFailure extends Failure{}