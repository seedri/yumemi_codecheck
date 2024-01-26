import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/view_model/main_page_vm.dart';

class DetailPage extends ConsumerWidget {
  final MainPageVM _vm = MainPageVM();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //今回表示するリポジトリのデータ
    Item dataItem = _vm.selectedRepository;
    _vm.setRef(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Detail"),
      ),
      body: Center(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.network(
                dataItem.owner.avatar_url,
              ),
            ),
            Text("リポジトリ名:${dataItem.name}"),
            Text("プロジェクト言語：${dataItem.language ?? "No Language"}"),
            Text("Star数${dataItem.stargazers_count}"),
            Text("Watcher数：${dataItem.watchers_count}"),
            Text("Fork数：${dataItem.forks_count}"),
            Text("Issue数：${dataItem.open_issues_count}"),
          ],
        ),
      )),
    );
  }
}
