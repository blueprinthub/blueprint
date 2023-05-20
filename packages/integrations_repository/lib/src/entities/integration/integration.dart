import 'package:equatable/equatable.dart';
import 'package:integrations_repository/src/entities/platform/platform.dart';

/// {@template integration}
/// Base class for integration with a third-party service.
/// Platform-specific integrations should extend this class with the proper
/// [platform] and additional properties.
/// {@endtemplate}
abstract class Integration extends Equatable {
  /// {@macro integration}
  const Integration(this.platform);

  /// The platform of the integration.
  final Platform platform;

  /// A method that returns the integration as a map to be used in the
  /// connect API. This is used to connect the integration to the app. Not
  /// all integrations have the same parameters, so this method must be
  /// implemented by the specific integration.
  Map<String, dynamic> toConnectApiParams();
}
