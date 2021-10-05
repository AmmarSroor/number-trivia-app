import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  Failure([List properties = const<dynamic>[]]) :super(properties);
}

// these are general failures
class ServerFailure extends Failure{}

class CacheFailure extends Failure{}