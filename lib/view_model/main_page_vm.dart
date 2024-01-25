import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/model/logic.dart';

final searchWordProvider = StateProvider<String>((ref) => '');
final logicProvider = StateProvider<Logic>((ref) => Logic());

AutoDisposeFutureProviderFamily<Repository, String> apiFamilyProvider =
    FutureProvider.autoDispose
        .family<Repository, String>((ref, searchWord) async {
  Logic logic = ref.watch(logicProvider);

  if (searchWord == '') {
    return Repository.empty;
  }
  return await logic.getRepository(searchWord);
});

class MainPageVM {
  late WidgetRef _ref;

  String get searchWord => _ref.watch(searchWordProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  AsyncValue<Repository> repositoryWithFamily(String searchWord) =>
      _ref.watch(apiFamilyProvider(searchWord));

  //検索ボタンを押下した時、searchWordを更新
  void onPressedSearchButton(String searchWord) {
    _ref.read(searchWordProvider.notifier).update((state) => searchWord);
  }
}
