// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:transcation_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:transcation_app/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:transcation_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';

import '../../features/authentication/data/repositories/auth_repository.dart'
    as _i935;
import '../../features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart'
    as _i531;
import '../../features/authentication/presentation/cubits/verification_cubit/verification_cubit.dart'
    as _i893;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i893.VerificationCubit>(
        () => _i893.VerificationCubit(gh<_i935.AuthRepository>()));
    gh.factory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
    gh.factory<AppUserCubit>(
        () => AppUserCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<SignInCubit>(
        () => SignInCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i531.SignUpCubit>(
        () => _i531.SignUpCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i935.AuthRepository>(
        () => _i935.AuthRepositoryImpl(authDataSource: gh<AuthRemoteDataSource>()));
    return this;
  }
}
