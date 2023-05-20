import 'package:json_annotation/json_annotation.dart';

part 'platform.g.dart';

/// {@template platform}
/// A platform that contains the project.
/// {@endtemplate}
@JsonSerializable()
class Platform {
  /// {@macro platform}
  const Platform({
    required this.id,
    required this.displayName,
    required this.iconUrl,
  });

  /// From json
  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  final String displayName;

  /// The URL of the icon for the platform.
  final String iconUrl;

  /// To json
  Map<String, dynamic> toJson() => _$PlatformToJson(this);
}
