import 'dart:convert';

import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource{
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();

}

class NumberTriviaRemoteDataSourceImplementation extends NumberTriviaRemoteDataSource{
  final http.Client client;

  NumberTriviaRemoteDataSourceImplementation({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
    return getTriviaFromUrl('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async{
    return getTriviaFromUrl('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> getTriviaFromUrl(String url)async{
    final response = await client.get(
        url,
        headers: {
          'Content Type-':'application/json'
        }
    );
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }
}