import 'package:integrations_repository/src/entities/platform.dart';

/// {@template integration}
/// Base class for integration with a third-party service.
/// Platform-specific integrations should extend this class with the proper
/// [platform] and additional properties.
/// {@endtemplate}
abstract class Integration {
  /// {@macro integration}
  Integration(this.platform);

  /// The platform of the integration.
  final Platform platform;
}
