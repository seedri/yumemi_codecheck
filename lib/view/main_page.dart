import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/view/detail_page.dart';
import 'package:yumemi_codecheck/view_model/main_page_vm.dart';
import 'package:yumemi_codecheck/view_model/theme_vm.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title, required this.isDarkMode});

  final String title;
  final bool isDarkMode;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  MainPageVM _vm = MainPageVM();
  ThemeVM _themeVM = ThemeVM();
  static const String _sharedPreferencesKey = 'isDark';
  late ScrollController scrollController;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    isLoading = false;
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.blueGrey : Colors.blue,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.125,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                child: const Text(
                  '設定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    color: widget.isDarkMode ? Colors.blueGrey : Colors.blue),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5),
                ),
              ),
              child: ListTile(
                title: Text(widget.isDarkMode ? "ライトモードにする" : "ダークモードにする"),
                onTap: () {
                  final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
                  ref
                      .read(isDarkModeProvider.notifier)
                      .update((state) => !_isDarkMode);
                  _themeVM.onThemeChaged(_sharedPreferencesKey, !_isDarkMode);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextField(
                maxLength: 256,
                textInputAction: TextInputAction.search,
                onSubmitted: (_text) => _vm.onPressedSearchButton(_text),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'キーワード',
                  labelText: 'リポジトリ名',
                  suffixIcon: Icon(Icons.sort),
                )),
            _vm.repositoryWithFamily(_vm.searchWord).when(
                  data: (data) {
                    if (data.total_count == 0) return Text('検索結果なし');
                    return Text('検索結果${data.total_count.toString()}件');
                  },
                  loading: () {
                    return Text('検索中...');
                  },
                  error: (error, stack) => Text(error.toString()),
                ),
            Expanded(
                child: _vm.repositoryWithFamily(_vm.searchWord).when(
                      data: (repository) {
                        //表示用のListに検索で得られたItemを追加
                        _vm.addRepositoryItemsList(repository);
                        scrollController.addListener(() async {
                          if (scrollController.position.pixels >=
                                  scrollController.position.maxScrollExtent *
                                      0.98 &&
                              ref.read(hasNextPageProvider) &
                                  !ref.read(isLoadingProvider)) {
                            ref
                                .read(isLoadingProvider.notifier)
                                .update((state) => true);
                            ref
                                .read(pageProvider.notifier)
                                .update((state) => state + 1);
                            await _vm
                                .repositoryNextPageWithFamily(_vm.page)
                                .when(
                                  data: (nextPageRepository) {
                                    debugPrint(
                                        'Next Page Data Received: ${nextPageRepository.toString()}');
                                    _vm.addRepositoryItemsList(
                                        nextPageRepository);
                                  },
                                  error: (error, stack) {
                                    isLoading = false;
                                    Text(error.toString());
                                  },
                                  loading: () => CircularProgressIndicator(),
                                );
                          }
                        });
                        return Scrollbar(
                          controller: scrollController,
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: ref.watch(showItemsProvider).length + 1,
                            itemBuilder: (context, index) {
                              if (index < ref.watch(showItemsProvider).length) {
                                return GestureDetector(
                                    child: Card(
                                      child: ListTile(
                                        leading: Image.network(
                                          ref
                                              .read(showItemsProvider)[index]
                                              .owner
                                              .avatar_url,
                                        ),
                                        title: Text(
                                          ref
                                              .read(showItemsProvider)[index]
                                              .name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        tileColor: Colors.white,
                                      ),
                                      elevation: 3,
                                      margin: EdgeInsets.all(3),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Colors.blueGrey, width: 1.2),
                                      ),
                                    ),
                                    onTap: () {
                                      debugPrint(index.toString());
                                      _vm.onRepositoyTapped(
                                          ref.read(showItemsProvider)[index]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(),
                                        ),
                                      );
                                    });
                              } else if (index != 0 &&
                                  index ==
                                      ref.watch(showItemsProvider).length &&
                                  ref.watch(hasNextPageProvider)) {
                                return const CupertinoActivityIndicator(
                                  radius: 20,
                                );
                              }
                            },
                          ),
                        );
                      },
                      error: (error, stack) => Text(error.toString()),
                      loading: () => const CupertinoActivityIndicator(
                        radius: 50,
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
