import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchWordProvider = StateProvider<String>((ref) => '');

class MainPageVM {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  void onPressedSearchButton(String searchWord) {
    _ref.read(searchWordProvider.notifier).update((state) => searchWord);
  }
}
