import 'dart:convert';

import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImplementation? dataSourceImplementation;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImplementation = NumberTriviaLocalDataSourceImplementation(
      sharedPreferences: mockSharedPreferences!,
    );
  });

  group(
    'getLastNumberTrivia',
    (){
      final testNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

      test(
        'should return NumberTrivia from SharedPreferenses when there is one in the cache',
        () async{
          when(mockSharedPreferences!.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

          final result = await dataSourceImplementation!.getLastNumberTrivia();

          verify(mockSharedPreferences!.getString(CACHED_NUMBER_TRIVIA));
          expect(result, equals(testNumberTriviaModel));
        }
      );

      test(
          'should throw a CacheException when there is not a cached value',
              () async{
            when(mockSharedPreferences!.getString(any))
                .thenReturn(null);

            final call = dataSourceImplementation!.getLastNumberTrivia;
            
            expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
          }
      );
    }
  );

  group(
      'cacheNumberTrivia',
          (){
        final testNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 1);

        test(
          'should call SharedPreferences to cache the data',
          () async{

             dataSourceImplementation!.cacheNumberTrivia(testNumberTriviaModel);

             final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
              verify(mockSharedPreferences!.setString(CACHED_NUMBER_TRIVIA,expectedJsonString));
            }
        );

      }
  );
}
