import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:first_project/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker{

  void main(){
    NetworkInfoImplementation? networkInfoImplementation;
    MockDataConnectionChecker? mockDataConnectionChecker;

    setUp((){
      mockDataConnectionChecker = MockDataConnectionChecker();
      networkInfoImplementation = NetworkInfoImplementation(mockDataConnectionChecker!);
    });

    group('isConnected',(){

      test(
        'should forward the call to DataConnectionChecker.hasConnection',
        () async{

          final tHasConnectionFuture = Future.value(true);

          when(mockDataConnectionChecker!.hasConnection)
              .thenAnswer((_) => tHasConnectionFuture);

          final result = networkInfoImplementation!.isConnected;

          verify(mockDataConnectionChecker!.hasConnection);
          expect(result, tHasConnectionFuture);

      });

    });
  }

}