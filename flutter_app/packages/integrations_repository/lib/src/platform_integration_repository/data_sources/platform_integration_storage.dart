
import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:integrations_repository/src/entities/entities.dart';
import 'package:integrations_repository/src/platform_integration_repository/mapper/platform_integration_mapper.dart';

/// {@template platform_integration_storage}
/// Base class to implement new integrations storage for a given [PlatformType].
/// This class is used by the PlatformIntegrationRepository to store and
/// retrieve integrations from a given platform.
/// To implement a new storage integration, you must extend this class and
/// implement the abstract methods.
/// {@endtemplate}
class PlatformIntegrationStorage<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationStorage] instance.
  PlatformIntegrationStorage({
    required FlutterSecureStorage storage,
    required PlatformIntegrationMapper<IntegrationType> mapper,
    String? storageKey,
  })  : _storageKey = storageKey ?? PlatformType.runtimeType.toString(),
        _storage = storage,
        _mapper = mapper,
        _streamController = StreamController<List<IntegrationType>>.broadcast();

  /// The storage used to store the integrations in the device.
  /// This is a singleton, so it will be the same instance for all the
  /// implementations of this class.
  final FlutterSecureStorage _storage;

  /// The mapper used to convert the integrations to json and vice versa.
  final PlatformIntegrationMapper<IntegrationType> _mapper;

  /// The key used to store the integrations in the secure storage.
  final String _storageKey;

  /// The stream controller used to emit the integrations.
  final StreamController<List<IntegrationType>> _streamController;

  /// Returns a stream of all integrations, reacting to integration changes.
  Stream<List<IntegrationType>> get integrationsStream =>
      _streamController.stream;

  /// Stores the given [integrations] in the secure storage.
  Future<void> storeIntegrations(List<IntegrationType> integrations) async {
    final itemsStorables = integrations.map((integration) {
      final map = _mapper.toJson(integration);
      return json.encode(map);
    }).toList();

    await _storage.write(
      key: _storageKey,
      value: json.encode(itemsStorables),
    );

    refresh();
  }

  /// Refresh the stream of integrations, emitting the new list of current
  /// integrations.
  void refresh() => _getAllIntegrations().then(_streamController.add);

  /// Delete the given [integration] from the secure storage.
  Future<void> deleteIntegration(IntegrationType integration) async {
    final integrations = await _getAllIntegrations();
    final newIntegrations =
        integrations.where((i) => i != integration).toList();

    await storeIntegrations(newIntegrations);
  }

  /// Returns the stored integrations.
  Future<List<IntegrationType>> _getAllIntegrations() async {
    final jsonString = await _storage.read(key: _storageKey);
    if (jsonString == null) {
      return [];
    }
    final integrationsDecoded = json.decode(jsonString);

    final integrations = (integrationsDecoded as List).map((e) {
      final json = jsonDecode(e as String);
      return _mapper.fromJson(json as Map<String, dynamic>);
    }).toList();

    return integrations;
  }
}
