import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';
import 'package:transcation_app/features/home/presentation/bloc/my_plans/my_plans_state.dart';
@injectable
class MyPlansCubit extends Cubit<MyPlansState>with MountedCubit<MyPlansState>  {
  MyPlansCubit(this.repository) : super(const MyPlansState.initial());
final MainRepository repository;

Future<void> getUserActivePlan(String token) async {
  emit(state.copyWith(status: MyPlansStatus.loading) );
  final response = await repository.getUserActivePlan(token);
  response.fold(
    (failure) => emit(state.copyWith(status: MyPlansStatus.error, errorMessage: failure.message)),
    (success) => emit(state.copyWith(status: MyPlansStatus.success, activePlans: success.plans)),
  );
}
 void getPlanReuslt(String token, String planId) async {
        emit(state.copyWith(status: MyPlansStatus.loading));

    final result = await repository.getPlanReuslt(token, planId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: MyPlansStatus.error,
        errorMessage: failure.message,
      )),
      (plan) {
        
        print("plan is $plan");
         emit(state.copyWith(
        status: MyPlansStatus.successGetPlanDetails,
        userActivePlan: plan,
      ));},
    );
  }
}