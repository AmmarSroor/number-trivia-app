import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/usecases/usecase.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main(){
  GetRandomNumberTrivia? useCase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockNumberTriviaRepository!);
  });

  final testNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
      'should get trivia from the repository',
          ()async{
        // arrange
        when(mockNumberTriviaRepository!.getRandomNumberTrivia())// expected error
            .thenAnswer((_) async => Right(testNumberTrivia));
        // act
        final result = await useCase!(NoParameters());

        // assert
        expect(result ,Right(testNumberTrivia));
        verify(mockNumberTriviaRepository!.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      }
  );
}