import 'dart:async';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:platform_integration_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/src/ui/ui.dart';

/// {@template platform_integration_repository}
/// Base class to implement new integrations for a given [PlatformType].
/// To implement a new repository integration, you must extend this class and
/// implement the abstract methods.
///
/// [IntegrationType] represents the base class for all integrations supported
/// by the repository. For example, if you are implementing a repository for
/// basic authentication and token authentication, you must create three
/// classes:
/// ```dart
/// class SomeBaseClass extends Integration {
///   ...
/// }
/// class SomeBasicAuthClass extends SomeBaseClass {
///   ...
/// }
/// class SomeTokenAuthClass extends SomeBaseClass {
///  ...
/// }
/// ```
/// {@endtemplate}
abstract class PlatformIntegrationRepository<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationRepository] instance.
  PlatformIntegrationRepository({
    required this.platform,
  });

  /// The platform that represents the repository
  final PlatformType platform;

  /// Returns all the tasks that are linked to an specific [project] and are
  /// related to the current user. There are multiple reasons why a task can be
  /// related to the current user, depending on the platform. In task management
  /// platforms, this can be because the user is the assignee of the task.
  /// In project management platforms, this can be because the user is a member
  Future<List<Task>> getProjectTasksRelatedToMe(Project project);

  /// Returns all the projects that are linked to an specific [integration].
  ///
  /// This will communicate with the specific platform apis to get the projects
  /// linked to given integration.
  Future<List<Project>> getProjectsFromIntegration(IntegrationType integration);

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<List<IntegrationType>> getIntegrations() {
    // TODO: implement this fethchig from firebase
    return Stream.value([]);
  }

  /// Creates a new [integration] in the repository.
  Future<void> createIntegration(IntegrationType integration) async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('authenticators-connect');

      final integrationParams = integration.toConnectApiParams();
      await callable<void>(integrationParams);
    } on FirebaseFunctionsException catch (e) {
      // TODO: catch the correct exceptions and throw them
      log('Error calling function authentications-connect: ${e.code} '
          '${e.message}: ${e.details} ');

      rethrow;
    }
  }

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(IntegrationType integration) {
    // TODO: comunicate with firebase to delete the integration
    return Future.value();
  }

  /// Returns a list of PlatformIntegrationTile that will be used to display
  /// all the possible integrations in the ui and how to integrate them.
  Iterable<PlatformIntegrationTile<PlatformType, IntegrationType>>
      getIntegrationTile(
    FutureOr<void> Function(IntegrationType) onIntegrationCreated,
  );
}
