import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/model/logic.dart';

final searchWordProvider = StateProvider<String>((ref) => '');
//画面表示するItemのProvider
final showItemsProvider = StateProvider<List<Item>>((ref) => []);
final pageProvider = StateProvider<int>((ref) => 1);
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

AutoDisposeFutureProviderFamily<Repository, String> nextPageapiFamilyProvider =
    FutureProvider.autoDispose
        .family<Repository, String>((ref, searchWord) async {
  Logic logic = Logic();

  if (searchWord == '') {
    return Repository.empty;
  }
  int page = ref.watch(pageProvider);
  return await logic.loadNextPage(searchWord, page);
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

  AsyncValue<Repository> repositoryNextPageWithFamily(String searchWord) =>
      _ref.watch(nextPageapiFamilyProvider(searchWord));

  //検索ボタンを押下した時、searchWordProviderを更新
  void onPressedSearchButton(String searchWord) {
    //現在表示している配列の初期化
    _ref.read(showItemsProvider).clear();
    _ref.read(searchWordProvider.notifier).update((state) => searchWord);
  }

  //リポジトリを押下した時、selectedRepositoryProviderを更新
  void onRepositoyTapped(Item item) {
    _ref.read(selectedRepositoryProvider.notifier).update((state) => item);
  }

  //repositoryItemsProviderに、取得したItemを追加
  void addRepositoryItemsList(Repository repository) {
    _ref.watch(showItemsProvider).addAll(repository.items);
  }
}
