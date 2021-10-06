import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/core/network/network_info.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:first_project/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:first_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock
    implements NetworkInfo {}

void main(){

  NumberTriviaRepositoryImplementation? repositoryImplementation;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImplementation = NumberTriviaRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource!,
      localDataSource: mockLocalDataSource!,
      networkInfo: mockNetworkInfo!,
    );
  });

  void runTestOnLine(Function? body){
    group(
      'device is online',
      (){
        setUp(() {
          when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
        });

        body!();
      });
  }

  void runTestOffLine(Function? body){
    group(
        'device is offline',
        (){
          setUp(() {
            when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
          });

          body!();
        });
  }

  group(
      'GetConcreteNumberTrivia',
          (){
        final testNumber = 1;
        final testNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: testNumber);
        final NumberTrivia testNumberTrivia = testNumberTriviaModel;

        test(
            'should check if the device is online',
                (){
              when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);

              repositoryImplementation!.getConcreteNumberTrivia(testNumber);

              verify(mockNetworkInfo!.isConnected);
            }
        );

        runTestOnLine(
          (){
            test(
                'should return remote data when the call th remote data source is success ',
                    ()async{
                  when(mockRemoteDataSource!.getConcreteNumberTrivia(any as int))
                      .thenAnswer((_) async => testNumberTriviaModel);

                  final result = await repositoryImplementation!.getConcreteNumberTrivia(testNumber);

                  verify(mockRemoteDataSource!.getConcreteNumberTrivia(testNumber));
                  expect(result, equals(Right(testNumberTrivia)));
                }
            );

            test(
                'should the data locally when the call th remote data source is success ',
                    ()async{
                  when(mockRemoteDataSource!.getConcreteNumberTrivia(any as int))
                      .thenAnswer((_) async => testNumberTriviaModel);

                  await repositoryImplementation!.getConcreteNumberTrivia(testNumber);

                  verify(mockRemoteDataSource!.getConcreteNumberTrivia(testNumber));
                  verify(mockLocalDataSource!.cacheNumberTrivia(testNumberTriviaModel));
                }
            );

            test(
                'should return server failure when the call th remote data source is usSuccess ',
                    ()async{
                  when(mockRemoteDataSource!.getConcreteNumberTrivia(any as int))
                      .thenThrow(ServerException());

                  final result = await repositoryImplementation!.getConcreteNumberTrivia(testNumber);

                  verify(mockRemoteDataSource!.getConcreteNumberTrivia(testNumber));
                  verifyZeroInteractions(mockLocalDataSource);
                  expect(result, equals(Left(ServerFailure())));
                }
            );

          }
            );

        runTestOffLine(
            (){
              test(
                  'should return last locally cached data when the cached data is present',
                      ()async{
                    when(mockLocalDataSource!.getLastNumberTrivia())
                        .thenAnswer((_)async => testNumberTriviaModel);

                    final result = await repositoryImplementation!.getConcreteNumberTrivia(testNumber);

                    verifyZeroInteractions(mockRemoteDataSource);
                    verify(mockLocalDataSource!.getLastNumberTrivia());
                    expect(result, equals(Right(testNumberTrivia)));
                  }
              );

              test(
                  'should return CacheFailure when there is no cached data present',
                      ()async{
                    when(mockLocalDataSource!.getLastNumberTrivia())
                        .thenThrow(CacheException());

                    final result = await repositoryImplementation!.getConcreteNumberTrivia(testNumber);

                    verifyZeroInteractions(mockRemoteDataSource);
                    verify(mockLocalDataSource!.getLastNumberTrivia());
                    expect(result, equals(Left(CacheFailure())));
                  }
              );
            }
        );
      });

  group(
      'GetRandomNumberTrivia',
          (){
        final testNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 123);
        final NumberTrivia testNumberTrivia = testNumberTriviaModel;

        test(
            'should check if the device is online',
                (){
              when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);

              repositoryImplementation!.getRandomNumberTrivia();

              verify(mockNetworkInfo!.isConnected);
            }
        );

        runTestOnLine(
                (){
              test(
                  'should return remote data when the call th remote data source is success ',
                      ()async{
                    when(mockRemoteDataSource!.getRandomNumberTrivia())
                        .thenAnswer((_) async => testNumberTriviaModel);

                    final result = await repositoryImplementation!.getRandomNumberTrivia();

                    verify(mockRemoteDataSource!.getRandomNumberTrivia());
                    expect(result, equals(Right(testNumberTrivia)));
                  }
              );

              test(
                  'should the data locally when the call th remote data source is success ',
                      ()async{
                    when(mockRemoteDataSource!.getRandomNumberTrivia())
                        .thenAnswer((_) async => testNumberTriviaModel);

                    await repositoryImplementation!.getRandomNumberTrivia();

                    verify(mockRemoteDataSource!.getRandomNumberTrivia());
                    verify(mockLocalDataSource!.cacheNumberTrivia(testNumberTriviaModel));
                  }
              );

              test(
                  'should return server failure when the call th remote data source is usSuccess ',
                      ()async{
                    when(mockRemoteDataSource!.getRandomNumberTrivia())
                        .thenThrow(ServerException());

                    final result = await repositoryImplementation!.getRandomNumberTrivia();

                    verify(mockRemoteDataSource!.getRandomNumberTrivia());
                    verifyZeroInteractions(mockLocalDataSource);
                    expect(result, equals(Left(ServerFailure())));
                  }
              );

            }
        );

        runTestOffLine(
                (){
              test(
                  'should return last locally cached data when the cached data is present',
                      ()async{
                    when(mockLocalDataSource!.getLastNumberTrivia())
                        .thenAnswer((_)async => testNumberTriviaModel);

                    final result = await repositoryImplementation!.getRandomNumberTrivia();

                    verifyZeroInteractions(mockRemoteDataSource);
                    verify(mockLocalDataSource!.getLastNumberTrivia());
                    expect(result, equals(Right(testNumberTrivia)));
                  }
              );

              test(
                  'should return CacheFailure when there is no cached data present',
                      ()async{
                    when(mockLocalDataSource!.getLastNumberTrivia())
                        .thenThrow(CacheException());

                    final result = await repositoryImplementation!.getRandomNumberTrivia();

                    verifyZeroInteractions(mockRemoteDataSource);
                    verify(mockLocalDataSource!.getLastNumberTrivia());
                    expect(result, equals(Left(CacheFailure())));
                  }
              );
            }
        );
      });
}
