import 'package:blueprint/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class IntegrationsModule {
  @lazySingleton
  IntegrationsCubit integrationsCubit(
    IntegrationsRepository integrationsRepository,
  ) =>
      IntegrationsCubit(
        integrationsRepository,
      );
}
