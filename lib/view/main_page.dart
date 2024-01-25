import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  void initState() {
    super.initState();
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
                    data: (data) => ListView.separated(
                      itemCount: data.items.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('リポジトリ名：${data.items[index].name}'),
                            Text(
                                'プロジェクト言語：${data.items[index].language ?? "言語情報なし"}'),
                            Text(
                                'Star数：${data.items[index].stargazers_count.toString()}'),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                    ),
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
}
