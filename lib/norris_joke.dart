import 'package:json_annotation/json_annotation.dart';

part 'norris_joke.g.dart';

@JsonSerializable()
class NorrisJoke {
  int? imageIndex;

  @JsonKey(name: 'icon_url')
  final String iconUrl;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'value')
  final String value;

  NorrisJoke(this.iconUrl, this.id, this.url, this.value);
  factory NorrisJoke.fromJson(Map<String, dynamic> json) =>
      _$NorrisJokeFromJson(json);
  Map<String, dynamic> toJson() => _$NorrisJokeToJson(this);
}
