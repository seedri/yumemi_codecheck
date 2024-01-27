import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:yumemi_codecheck/view_model/main_page_vm.dart';

class DetailPage extends ConsumerWidget {
  final MainPageVM _vm = MainPageVM();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _vm.setRef(ref);

    //今回表示するリポジトリのデータ
    Item dataItem = _vm.selectedRepository;

    return Scaffold(
      appBar: AppBar(
        title: const Text("リポジトリ詳細"),
      ),
      body: Center(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: dataItem.owner.avatar_url,
                ),
              ),
            ),
            Text("リポジトリ名:${dataItem.name}"),
            Text("プロジェクト言語：${dataItem.language ?? "No Language"}"),
            Text("Star数：${dataItem.stargazers_count}"),
            Text("Watcher数：${dataItem.watchers_count}"),
            Text("Fork数：${dataItem.forks_count}"),
            Text("Issue数：${dataItem.open_issues_count}"),
          ],
        ),
      )),
      bottomNavigationBar: ElevatedButton(
        child: Text('閉じる'),
        onPressed: () {
          return Navigator.pop(context);
        },
      ),
    );
  }
}
