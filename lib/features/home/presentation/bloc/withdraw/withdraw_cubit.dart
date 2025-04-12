import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';

part 'withdraw_state.dart';

@injectable
class WithdrawCubit extends Cubit<WithdrawState> with MountedCubit<WithdrawState> {
  final MainRepository _repository;

  WithdrawCubit(this._repository) : super(WithdrawState(status: WithdrawStatus.initial));

  Future<void> getBalance({required String token}) async {
    emit(state.copyWith(status: WithdrawStatus.loading));
    final result = await _repository.getUserProfile(token: token);
    result.fold(
      (l) => emit(state.copyWith(status: WithdrawStatus.failure, message: l.message)),
      (r) => emit(state.copyWith(status: WithdrawStatus.getBalance, balance: r.balance)),
    );
  }
  Future<void> withdraw( Map<String ,dynamic> data) async {
    emit(state.copyWith(status: WithdrawStatus.loading));
    final result =await  _repository.withdraw( data);
    result.fold(
          (l) => emit(state.copyWith(status: WithdrawStatus.failure, message: l.message)),
          (r) => emit(state.copyWith(status: WithdrawStatus.success, message: r.message,balance: r.user?.balance)), 
    );
  }
}