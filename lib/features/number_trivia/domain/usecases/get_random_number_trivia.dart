import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/core/usecases/usecase.dart';
import 'package:first_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';


class GetRandomNumberTrivia implements UseCase<NumberTrivia ,NoParameters>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParameters parameter) async{
    return await repository.getRandomNumberTrivia();
  }
  
}

