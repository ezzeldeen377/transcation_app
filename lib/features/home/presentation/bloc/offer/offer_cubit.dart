import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/plans_response.dart';
import 'package:transcation_app/features/home/data/models/subscription_response.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';

part 'offer_state.dart';

@injectable
class OfferCubit extends Cubit<OfferState> with MountedCubit<OfferState>  {
  OfferCubit(this.repository) : super(OfferState(status: OfferStatus.initial));
  final MainRepository repository;

  Future<void> getOffers() async {
    emit(state.copyWith(status: OfferStatus.loading));
    final result = await repository.getAllOffers();
    result.fold(
        (failure) => emit(state.copyWith(
            status: OfferStatus.failure, message: failure.message)),
        (success) => emit(state.copyWith(
            status: OfferStatus.successGetOffer, offers: success.offers)));
  }
  Future<void> getUserActivePlan(String token) async {
  emit(state.copyWith(status: OfferStatus.loading) );
  final response = await repository.getUserActivePlan(token);
  response.fold(
    (failure) => emit(state.copyWith(status: OfferStatus.failure, message: null)),
    (success) => emit(state.copyWith(status: OfferStatus.successGetActiveUserPlans, userActivePlans: success.plans)),
  );
}

void subscribePlan(String token, int planId) async {
    emit(state.copyWith(status: OfferStatus.loading));
    final response = await repository.subscribePlan(token, planId);
    response.fold(
      (failure) => emit(
          state.copyWith(status: OfferStatus.failure, message: failure.message)),
      (success) => emit(state.copyWith(
          status: OfferStatus.subscribePlan,
          message: success.message,
          subscriptedPlan: success.userPlan)),
    );
  }
  void getPlanReuslt(String token, String planId) async {
    emit(state.copyWith(status: OfferStatus.loading));
    final result = await repository.getPlanReuslt(token, planId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OfferStatus.failure,
        message: failure.message,
      )),
      (plan) => emit(state.copyWith(
        status: OfferStatus.successGetPlanDetails,
        userActivePlan: plan,
      )),
    );
  }
}
