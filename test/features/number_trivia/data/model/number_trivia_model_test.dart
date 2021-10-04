import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final testNumberTriviaModel = NumberTriviaModel(
      text: "Test Text",
      number: 1,
  );

  test(
    'Should be a subclass of NumberTrivia entity',
    ()async{
      expect(testNumberTriviaModel, isA<NumberTriviaModel>());
    }
  );

  group('fromJson',(){
    test(
      'should return a valid model when the json number is an integer',
      ()async{
        final Map<String ,dynamic> jsonMap = json.decode(fixture('trivia.json'));

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, testNumberTriviaModel);
      }
    );

    test(
        'should return a valid model when the json number is regarded as a double',
            ()async{
          final Map<String ,dynamic> jsonMap = json.decode(fixture('trivia_double.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);

          expect(result, testNumberTriviaModel);
        }
    );
  });

  group('toJson',(){
    test(
        'should return a json map containing the proper data',
        ()async{
          final result = testNumberTriviaModel.toJson();
          final expectedMap = {
            'text': 'Test Text',
            'number': 1,
          };
          expect(result, expectedMap);
        }
    );

  });

}