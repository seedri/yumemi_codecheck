import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/model/logic.dart';

final searchWordProvider = StateProvider<String>((ref) => '');
//画面表示するItemのProvider
final showItemsProvider = StateProvider<List<Item>>((ref) => []);
final pageProvider = StateProvider<int>((ref) => 1);
//検索結果に次ページが残っているか否か
final hasNextPageProvider = StateProvider<bool>((ref) => false);
final isLoadingProvider = StateProvider<bool>((ref) => false);
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

AutoDisposeFutureProviderFamily<Repository, int> nextPageapiFamilyProvider =
    FutureProvider.autoDispose.family<Repository, int>((ref, page) async {
  Logic logic = Logic();
  String searchWord = ref.read(searchWordProvider);
  if (searchWord == '') {
    return Repository.empty;
  }

  //これから読み込むページが最終か否か
  late bool isFinalPage;
  ref.watch(apiFamilyProvider(searchWord)).whenData((repository) {
    isFinalPage = page * 100 > repository.total_count;
  });
  ref.read(hasNextPageProvider.notifier).update((state) => !isFinalPage);
  return await logic.loadNextPage(searchWord, page);
});

class MainPageVM {
  late WidgetRef _ref;

  String get searchWord => _ref.watch(searchWordProvider);

  int get page => _ref.watch(pageProvider);

  Item get selectedRepository => _ref.watch(selectedRepositoryProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  AsyncValue<Repository> repositoryWithFamily(String searchWord) {
    bool hasNextPage = false;

    final repositoryAsync = _ref.watch(apiFamilyProvider(searchWord));

    repositoryAsync.whenData((repository) {
      if (repository.total_count > 100) {
        hasNextPage = true;
      }
    });

    // 遅延して更新を行う
    Future(() {
      _ref.read(hasNextPageProvider.notifier).update((state) => hasNextPage);
    });

    return repositoryAsync;
  }

  AsyncValue<Repository> repositoryNextPageWithFamily(int page) =>
      _ref.watch(nextPageapiFamilyProvider(page));

  //検索ボタンを押下した時、searchWordProviderを更新
  void onPressedSearchButton(String searchWord) {
    //現在表示している配列の初期化およびページ条件のリセット
    _ref.read(showItemsProvider).clear();
    _ref.read(hasNextPageProvider.notifier).update((state) => false);
    _ref.read(pageProvider.notifier).update((state) => 1);
    _ref.read(isLoadingProvider.notifier).update((state) => false);

    //検索ワードの更新、トリガー
    _ref.read(searchWordProvider.notifier).update((state) => searchWord);
  }

  //リポジトリを押下した時、selectedRepositoryProviderを更新
  void onRepositoyTapped(Item item) {
    _ref.read(selectedRepositoryProvider.notifier).update((state) => item);
  }

  //repositoryItemsProviderに、取得したItemを追加
  void addRepositoryItemsList(Repository repository) {
    _ref.watch(showItemsProvider).addAll(repository.items);
    // 遅延して更新を行う
    Future(() {
      _ref.read(isLoadingProvider.notifier).update((state) => false);
    });
  }
}
