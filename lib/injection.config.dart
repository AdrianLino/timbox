// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:timbox/src/di/app_module.dart' as _i940;
import 'package:timbox/src/di/firebase_service.dart' as _i794;
import 'package:timbox/src/domain/repository/auth_repository.dart' as _i348;
import 'package:timbox/src/domain/use_cases/auth/auth_usecases.dart' as _i710;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i794.FirebaseService>(
      () => appModule.firebaseService,
      preResolve: true,
    );
    gh.factory<_i348.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i710.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i940.AppModule {}
