import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/failures.dart';

class InputConverter {

  Either<Failure ,int> convertStringToInteger(String str){
    try{
      final number = int.parse(str);
      if(number < 0) throw FormatException();
      return Right(number);

    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure{
  @override
  List<Object?> get props => [];
}