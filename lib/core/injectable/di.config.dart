// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/remote/remote_ds.dart' as _i598;
import '../../data/data_sources/remote/remote_ds_impl.dart' as _i917;
import '../../data/repositories/weather_repo/weather_repo_impl.dart' as _i737;
import '../../domain/repositories/weather_repo/weather_repo.dart' as _i690;
import '../../domain/use_cases/weather_use_case.dart' as _i1049;
import '../dio/dio_module.dart' as _i977;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.proviedDio());
    gh.factory<_i598.RemoteDs>(() => _i917.RemoteDsImpl(dio: gh<_i361.Dio>()));
    gh.factory<_i690.WeatherRepo>(
      () => _i737.WeatherRepoImpl(remoteDs: gh<_i598.RemoteDs>()),
    );
    gh.factory<_i1049.WeatherUseCase>(
      () => _i1049.WeatherUseCase(weatherRepo: gh<_i690.WeatherRepo>()),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
