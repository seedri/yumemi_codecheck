import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  const factory Repository(
      {required String title,
      required int total_count,
      required bool incomplete_results,
      required List<Item> items}) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item(
      {required String id,
      required String name,
      required Owner owner,
      required String language,
      required int stargazers_count,
      required int watchers_count,
      required int forks_count,
      required int open_issues_count}) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Owner with _$Owner {
  const factory Owner({required String avatar_url}) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
