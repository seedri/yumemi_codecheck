import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/view/main_page.dart';
import 'package:yumemi_codecheck/view_model/theme_vm.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDarkMode
          ? ThemeData.dark()
          : ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(
        title: 'Repository Search',
        isDarkMode: _isDarkMode,
      ),
    );
  }
}
