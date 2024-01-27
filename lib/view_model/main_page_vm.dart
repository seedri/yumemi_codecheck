import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/model/logic.dart';

final searchWordProvider = StateProvider<String>((ref) => '');
final repositoryItemsProvider = StateProvider<List<Item>>((ref) => []);
final selectedRepositoryProvider = StateProvider<Item>((ref) => Item(
    id: 0,
    name: "",
    owner: Owner(avatar_url: ""),
    language: null,
    stargazers_count: 0,
    watchers_count: 0,
    forks_count: 0,
    open_issues_count: 0));

AutoDisposeFutureProviderFamily<Repository, String> apiFamilyProvider =
    FutureProvider.autoDispose
        .family<Repository, String>((ref, searchWord) async {
  Logic logic = Logic();

  if (searchWord == '') {
    return Repository.empty;
  }
  return await logic.getRepository(searchWord);
});

class MainPageVM {
  late WidgetRef _ref;

  String get searchWord => _ref.watch(searchWordProvider);

  Item get selectedRepository => _ref.watch(selectedRepositoryProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  AsyncValue<Repository> repositoryWithFamily(String searchWord) =>
      _ref.watch(apiFamilyProvider(searchWord));

  //検索ボタンを押下した時、searchWordProviderを更新
  void onPressedSearchButton(String searchWord) {
    _ref.read(searchWordProvider.notifier).update((state) => searchWord);
  }

  //リポジトリを押下した時、selectedRepositoryProviderを更新
  void onRepositoyTapped(Item item) {
    _ref.read(selectedRepositoryProvider.notifier).update((state) => item);
  }

  //repositoryItemsProviderに、取得したItemを追加
  void addRepositoryItemsList(Repository repository) {
    _ref.watch(repositoryItemsProvider).addAll(repository.items);
  }
}
