import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                            scrollController.position.maxScrollExtent * 1) {
                          ref
                              .read(pageProvider.notifier)
                              .update((state) => state + 1);
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
                            } else {
                              //次ページのデータ表示用のボタン
                              return ElevatedButton(
                                  onPressed: () async {
                                    ref
                                        .read(pageProvider.notifier)
                                        .update((state) => state + 1);
                                  },
                                  child: const Text('さらにデータを表示'));
                            }
                          },
                        ),
                      );
                    },
                    error: (error, stack) => Text(error.toString()),
                    loading: () => AspectRatio(
                      aspectRatio: 0.3,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
