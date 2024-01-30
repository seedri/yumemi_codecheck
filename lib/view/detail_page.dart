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
                width: 120,
                height: 120,
                child: CachedNetworkImage(
                  imageUrl: dataItem.owner.avatar_url,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StyledText("リポジトリ名:${dataItem.name}"),
            StyledText("プロジェクト言語：${dataItem.language ?? "No Language"}"),
            StyledText("Star数:${dataItem.stargazers_count}"),
            StyledText("Watcher数:${dataItem.watchers_count}"),
            StyledText("Fork数:${dataItem.forks_count}"),
            StyledText("Issue数:${dataItem.open_issues_count}"),
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

class StyledText extends StatelessWidget {
  final String text;

  const StyledText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
