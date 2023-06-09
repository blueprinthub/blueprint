import 'package:github_repository/src/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_basic_auth_integration.g.dart';

/// A GitHub integration that uses basic authentication (username and password).
/// This one is not recommended, as it is not secure, and it will not work with
/// some services and platforms like Web due to CORS restrictions.
@JsonSerializable()
class GitHubBasicAuthIntegration extends GitHubIntegration {
  /// Creates a new [GitHubBasicAuthIntegration] instance with the provided
  const GitHubBasicAuthIntegration({
    required this.username,
    required this.password,
  }) : super();

  /// Creates a new [GitHubBasicAuthIntegration] instance from a JSON object.
  factory GitHubBasicAuthIntegration.fromJson(Map<String, dynamic> json) =>
      _$GitHubBasicAuthIntegrationFromJson(json);

  /// The password of the GitHub user.
  final String password;

  final String username;

  @override
  List<Object?> get props => [username, password];

  /// Converts this [GitHubBasicAuthIntegration] instance to a JSON object.
  /// Adds the type of the integration to the JSON object.
  @override
  Map<String, dynamic> toJson() => _$GitHubBasicAuthIntegrationToJson(this)
    ..addAll({'type': 'basic_auth', 'platformId': platform.id});
}
