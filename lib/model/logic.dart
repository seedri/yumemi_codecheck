import 'dart:convert';
import 'package:yumemi_codecheck/data/repository.dart';
import 'package:http/http.dart' as http;

class Logic {
  Future<Repository> getRepository(String searchText) async {
    final apiUrl =
        'https://api.github.com/search/repositories?q=$searchText&per_page=100';
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception('検索エラー');
    }

    var jsonData = json.decode(response.body);

    return Repository.fromJson(jsonData);
  }

  Future<Repository> loadNextPage(String searchText, int page) async {
    final apiUrl =
        'https://api.github.com/search/repositories?q=$searchText&per_page=100&page=$page';
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception('検索エラー');
    }

    var jsonData = json.decode(response.body);
    return Repository.fromJson(jsonData);
  }
}
