import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integrations_repository/src/entities/entities.dart';

const _platformsCollectionName = 'platforms';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    required FirebaseFirestore firestore,
  }) {
    _platformsCollection = firestore
        .collection(_platformsCollectionName)
        .withConverter(
          fromFirestore: (snapshot, _) => Platform.fromJson(snapshot.data()!),
          toFirestore: (platform, _) => platform.toJson(),
        );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getAllIntegrations() {
    return Stream.value([]);
  }

  /// Returns a stream of all integrations from all repositories.
  Stream<Iterable<Platform>> getAllPlatforms() =>
      _platformsCollection.snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => doc.data()),
          );

  /// Returns a stream of all the projects that are linked to the app
  Stream<Iterable<Project>> getAllProjects() {
    return Stream.value([]);
  }

  /// Returns a stream of all tasks that are related to the current user in all
  /// the projects that are linked to the app.
  Stream<Iterable<Task>> getAllTasksRelatedToMe() => getAllProjects()
      .asyncMap(
        (projects) => Future.wait(
          projects.map(_getProjectTasksRelatedToMe),
        ),
      )
      .map((tasks) => tasks.expand((e) => e));

  /// Adds a new [integration] to the repository.
  Future<void> addIntegration(Integration integration) async {}

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(Integration integration) async {}

  /// Returns all the tasks that are linked to an specific [project].
  Future<Iterable<Task>> _getProjectTasksRelatedToMe(Project project) {
    // TODO: implement _getProjectTasksRelatedToMe
    return Future.value([]);
  }

  /// Returns all the projects that are under the give repository.
  /// If the integration is not found, because it does not belong to the
  /// repository, it returns an empty list.
  Stream<List<Project>> _getPlatformProjects(
    Platform platform,
  ) {
    return Stream.value([]);
  }

  /// Returns all the projects that are linked to an specific [integration].
  Future<Iterable<Project>> _getProjectsFromIntegration(
    Integration integration,
  ) async {
    return [];
  }
}
