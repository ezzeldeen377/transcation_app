import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/authentication/data/model/login_response.dart';
import 'package:transcation_app/features/authentication/data/repositories/auth_repository.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/notifcation_response.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/data/models/subscription_response.dart';
import 'package:transcation_app/features/home/data/models/transaction_history_response.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';

part 'home_cubit_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> with MountedCubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState(status: HomeStatus.initial));
  final MainRepository repository;

  Future<void> getUserProfile({required String token}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    print("start");
    final response = await repository.getUserProfile(token: token);
    response.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.failure)),
      (user) =>
          emit(state.copyWith(status: HomeStatus.successGetUser, user: user)),
    );
  }

  void getAllPlans() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await repository.getAllPlans();
    response.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.initial)),
      (response) => emit(state.copyWith(
          status: HomeStatus.successGetUser, plans: response.plans)),
    );
  }

  Future<void> getAllNotifcations() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await repository.getAllNotifcations();
    response.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.failure)),
      (response) => emit(state.copyWith(
          status: HomeStatus.successGetUser,
          notifications: response.notifications)),
    );
  }

  Future<void> getUserActivePlan(String token) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await repository.getUserActivePlan(token);
    response.fold(
      (failure) => emit(
          state.copyWith(status: HomeStatus.failure, message: null)),
      (success) => emit(state.copyWith(
          status: HomeStatus.successGetUserActivePlans,
          userActivePlans: success.plans)),
    );
  }

  void subscribePlan(String token, int planId) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await repository.subscribePlan(token, planId);
    response.fold(
      (failure) => emit(
          state.copyWith(status: HomeStatus.failure, message: failure.message)),
      (success) => emit(state.copyWith(
          status: HomeStatus.subscribePlan,
          message: success.message,
          subscriptedPlan: success.userPlan)),
    );
  }

  void checkPlans(String token) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await repository.checkPlans(token);
    response.fold(
      (failure) => emit(
          state.copyWith(status: HomeStatus.failure, message: null)),
      (success) => emit(state.copyWith(
        status: HomeStatus.successCheckPlans,
      )),
    );
  }
  
  Future<void> getTransactionHistory(String token) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await repository.getLastTranscations(token);

    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        message: failure.message,
      )),
      (history) async {
        if (history.subscriptions==null) {
          emit(state.copyWith(
            status: HomeStatus.successGetTranscation,
            history: history,
            planDetails: {},
          ));
          return;
        }

        try {
          final subscriptionsWithDetails = await Future.wait(
            (history.subscriptions ?? []).map((subscription) async {
              
              final planResult = await repository.getPlanReuslt(
                token,
                subscription.planId.toString(),
              );
              return planResult.fold(
                (failure) => null,
                (plan) => (subscription, plan),
              );
            }),
          );

          final validDetails = subscriptionsWithDetails
              .where((element) => element != null)
              .map((e) => MapEntry(e!.$1.planId, e.$2))
              .toList();

          emit(state.copyWith(
            status: HomeStatus.successGetTranscation,
            history: history,
            planDetails: Map.fromEntries(validDetails),
          ));
        } catch (e) {
          emit(state.copyWith(
            status: HomeStatus.failure,
            message: 'Failed to fetch plan details',
          ));
        }
      },
    );
  }
  void getPlanReuslt(String token, String planId) async {
        emit(state.copyWith(status: HomeStatus.loading));

    final result = await repository.getPlanReuslt(token, planId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        message: failure.message,
      )),
      (plan) => emit(state.copyWith(
        status: HomeStatus.successGetPlanDetails,
        userActivePlan: plan,
      )),
    );
  }
 
}
