// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_repository/authentication_repository.dart'
    as _i3;
import 'package:blueprint/authentication/module/authentication_module.dart'
    as _i22;
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart'
    as _i16;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i12;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i13;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i14;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i15;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i23;
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart'
    as _i10;
import 'package:blueprint/core/module/core_module.dart' as _i19;
import 'package:blueprint/core/module/firebase_module.dart' as _i20;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i21;
import 'package:blueprint/integrations/state_management/cubit/integrations_cubit.dart'
    as _i6;
import 'package:blueprint/settings/module/settings_module.dart' as _i17;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i8;
import 'package:blueprint/tasks/module/task_module.dart' as _i18;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart' as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i11;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:integrations_repository/integrations_repository.dart' as _i7;

const String _dev = 'dev';
const String _prod = 'prod';
const String _stg = 'stg';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authenticationModule = _$AuthenticationModule();
    final firebaseModule = _$FirebaseModule();
    final coreModule = _$CoreModule();
    final integrationsModule = _$IntegrationsModule();
    final settingsModule = _$SettingsModule();
    final taskModule = _$TaskModule();
    final blueprintModule = _$BlueprintModule();
    gh.lazySingleton<_i3.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i3.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i3.GoogleAuthenticationProvider>(
        () => authenticationModule.googleAuthenticationProvider());
    gh.lazySingleton<_i6.IntegrationsCubit>(() =>
        integrationsModule.integrationsCubit(gh<_i7.IntegrationsRepository>()));
    gh.lazySingleton<_i8.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.factory<_i9.TasksCubit>(
        () => taskModule.taskCubit(gh<_i7.IntegrationsRepository>()));
    gh.lazySingleton<_i10.TodaysBlueprintCubit>(
        () => blueprintModule.blueprintCubit(gh<_i8.SettingsBloc>()));
    await gh.singletonAsync<_i4.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i4.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i11.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i3.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i3.AppleAuthenticationProvider>(),
              gh<_i3.GoogleAuthenticationProvider>(),
              gh<_i3.FacebookAuthenticationProvider>(),
              gh<_i11.FirebaseAuth>(),
            ));
    gh.factory<_i12.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i13.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i14.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i15.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i16.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i3.AuthenticationRepositoryContract>()));
    return this;
  }
}

class _$SettingsModule extends _i17.SettingsModule {}

class _$TaskModule extends _i18.TaskModule {}

class _$CoreModule extends _i19.CoreModule {}

class _$FirebaseModule extends _i20.FirebaseModule {}

class _$IntegrationsModule extends _i21.IntegrationsModule {}

class _$AuthenticationModule extends _i22.AuthenticationModule {}

class _$BlueprintModule extends _i23.BlueprintModule {}
