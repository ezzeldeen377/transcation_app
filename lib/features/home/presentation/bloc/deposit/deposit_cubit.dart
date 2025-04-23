import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';

part 'deposit_state.dart';
@injectable
class DepositCubit extends Cubit<DepositState> with MountedCubit<DepositState> {
  final MainRepository _repository;

  DepositCubit(this._repository) : super(DepositState(status: DepositStatus.initial));
  Future<void> getBalance({required String token}) async {
    emit(state.copyWith(status: DepositStatus.loading));
    final result = await _repository.getUserProfile(token: token);
    result.fold(
          (l) => emit(state.copyWith(status: DepositStatus.failure, message: l.message)),
          (r) => emit(state.copyWith(status: DepositStatus.success, balance: r.balance)), 
    );
  }
  
}