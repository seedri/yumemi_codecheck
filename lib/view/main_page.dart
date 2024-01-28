import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/view/detail_page.dart';
import 'package:yumemi_codecheck/view_model/main_page_vm.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String text = '';
  MainPageVM _vm = MainPageVM();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(onChanged: (_text) {
              text = _text;
            }),
            ElevatedButton(
                onPressed: () {
                  _vm.onPressedSearchButton(text);
                },
                child: Text('検索')),
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
                      scrollController.addListener(() {
                        if (scrollController.position.pixels >=
                            scrollController.position.maxScrollExtent * 0.98) {
                          ref
                              .read(pageProvider.notifier)
                              .update((state) => state + 1);
                          _vm.repositoryNextPageWithFamily(_vm.searchWord).when(
                                data: (nextPageEepository) {
                                  _vm.addRepositoryItemsList(
                                      nextPageEepository);
                                },
                                error: (error, stack) => Text(error.toString()),
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
                              return ListTile(
                                  title: GestureDetector(
                                      child: Text(
                                          'リポジトリ名：${ref.read(showItemsProvider)[index].name}'),
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
                                      }));
                            } else if (index != 0 &&
                                index == ref.watch(showItemsProvider).length) {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      );
                    },
                    error: (error, stack) => Text(error.toString()),
                    loading: () => AspectRatio(
                      aspectRatio: 1,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // 変更点: ListView.builderの部分を外部のメソッドに切り出し
  Widget _buildListViewWidget(List<Item> items) {
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index < items.length) {
          return ListTile(
              // ... (変更なし)
              );
        } else {
          return ElevatedButton(
            onPressed: () async {
              ref.read(pageProvider.notifier).update((state) => state + 1);
            },
            child: const Text('さらに読み込む'),
          );
        }
      },
    );
  }
}
