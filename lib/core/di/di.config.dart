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

import '../../features/authentication/data/data_source/auth_remote_data_source.dart'
    as _i21;
import '../../features/authentication/data/repositories/auth_repository.dart'
    as _i935;
import '../../features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart'
    as _i670;
import '../../features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart'
    as _i531;
import '../../features/authentication/presentation/cubits/verification_cubit/verification_cubit.dart'
    as _i893;
import '../../features/home/data/datasources/main_remote_data_source.dart'
    as _i416;
import '../../features/home/data/repositories/main_repository.dart' as _i472;
import '../../features/home/presentation/bloc/deposit/deposit_cubit.dart'
    as _i513;
import '../../features/home/presentation/bloc/history/history_cubit.dart'
    as _i829;
import '../../features/home/presentation/bloc/home/home_cubit_cubit.dart'
    as _i257;
import '../../features/home/presentation/bloc/my_plans/my_plans_cubit.dart'
    as _i281;
import '../../features/home/presentation/bloc/offer/offer_cubit.dart' as _i374;
import '../../features/home/presentation/bloc/withdraw/withdraw_cubit.dart'
    as _i56;
import '../common/cubit/app_user/app_user_cubit.dart' as _i94;

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
    gh.factory<_i416.MainRemoteDataSource>(
        () => _i416.MainRemoteDataSourceImpl());
    gh.factory<_i21.AuthRemoteDataSource>(
        () => _i21.AuthRemoteDataSourceImpl());
    gh.factory<_i935.AuthRepository>(() => _i935.AuthRepositoryImpl(
        authDataSource: gh<_i21.AuthRemoteDataSource>()));
    gh.factory<_i94.AppUserCubit>(
        () => _i94.AppUserCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i670.SignInCubit>(
        () => _i670.SignInCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i531.SignUpCubit>(
        () => _i531.SignUpCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i472.MainRepository>(() =>
        _i472.MainRepositoryImpl(dataSource: gh<_i416.MainRemoteDataSource>()));
    gh.factory<_i513.DepositCubit>(
        () => _i513.DepositCubit(gh<_i472.MainRepository>()));
    gh.factory<_i56.WithdrawCubit>(
        () => _i56.WithdrawCubit(gh<_i472.MainRepository>()));
    gh.factory<_i829.HistoryCubit>(
        () => _i829.HistoryCubit(gh<_i472.MainRepository>()));
    gh.factory<_i257.HomeCubit>(
        () => _i257.HomeCubit(gh<_i472.MainRepository>()));
    gh.factory<_i281.MyPlansCubit>(
        () => _i281.MyPlansCubit(gh<_i472.MainRepository>()));
    gh.factory<_i374.OfferCubit>(
        () => _i374.OfferCubit(gh<_i472.MainRepository>()));
    gh.factory<_i893.VerificationCubit>(
        () => _i893.VerificationCubit(gh<_i935.AuthRepository>()));
    return this;
  }
}
