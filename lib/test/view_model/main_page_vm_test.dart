import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/model/logic.dart';

class MockLogic extends Mock implements Logic {}

//下記のテストはエラーが出て通りませんでした
void main() {
  group('apiFamilyProvider', () {
    test('successful call returns Repository', () async {
      final mockLogic = MockLogic();
      final apiFamilyProvider =
          AutoDisposeFutureProviderFamily<Repository, String>(
        (ref, searchWord) async => mockLogic.getRepository(searchWord),
      );
      final container = ProviderContainer();

      // Act
      final result = await container.read(apiFamilyProvider(''));

      // Assert
      expect(result, isA<Repository>());
    });
  });
}
