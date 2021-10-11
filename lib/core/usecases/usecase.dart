import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_project/core/error/failures.dart';


abstract class UseCase<Type ,Parameter> {
  Future<Either<Failure,Type>> call(Parameter parameter);

}

class NoParameters extends Equatable{
  @override
  List<Object?> get props => [];
}