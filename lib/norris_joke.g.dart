// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norris_joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NorrisJoke _$NorrisJokeFromJson(Map<String, dynamic> json) => NorrisJoke(
      json['icon_url'] as String,
      json['id'] as String,
      json['url'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$NorrisJokeToJson(NorrisJoke instance) =>
    <String, dynamic>{
      'icon_url': instance.iconUrl,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };
