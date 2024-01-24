// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryImpl _$$RepositoryImplFromJson(Map<String, dynamic> json) =>
    _$RepositoryImpl(
      title: json['title'] as String,
      total_count: json['total_count'] as int,
      incomplete_results: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RepositoryImplToJson(_$RepositoryImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'total_count': instance.total_count,
      'incomplete_results': instance.incomplete_results,
      'items': instance.items,
    };

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String,
      node_id: json['node_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.node_id,
      'name': instance.name,
    };
