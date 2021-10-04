import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app/core/error/failures.dart';

abstract class UseCase<Type ,Parameter> {
  Future<Either<Failure,Type>> call(Parameter parameter);
}

class NoParameters extends Equatable{}