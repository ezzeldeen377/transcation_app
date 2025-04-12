// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'offer_cubit.dart';

enum OfferStatus {
  initial,
  loading,
  successGetOffer,
  failure,
  successGetActiveUserPlans,
  successGetPlanDetails,
  subscribePlan
}

extension OfferStateX on OfferState {
  bool get isInitial => status == OfferStatus.initial;
  bool get isLoading => status == OfferStatus.loading;
  bool get isSuccess => status == OfferStatus.successGetOffer;
  bool get isFailure => status == OfferStatus.failure;
  bool get isSuccessActiveUserPlans =>
      status == OfferStatus.successGetActiveUserPlans;
  bool get isSubscribePlan => status == OfferStatus.subscribePlan;
  bool get isSuccessPlanDetails =>
      status == OfferStatus.successGetPlanDetails;
}

class OfferState {
  final OfferStatus status;
  final String? message;
  final List<Plan>? offers;
    final SubscriptedPlan? subscriptedPlan;
  final List<ActivePlan>? userActivePlans;
  final ActivePlan? userActivePlan;

  OfferState({
    required this.status,
    this.message,
    this.offers,
    this.subscriptedPlan,
    this.userActivePlan,
    this.userActivePlans,
  });

  OfferState copyWith({
    OfferStatus? status,
    String? message,
    List<Plan>? offers,
    SubscriptedPlan? subscriptedPlan,
    List<ActivePlan>? userActivePlans,
    ActivePlan? userActivePlan,
  }) {
    return OfferState(
      status: status ?? this.status,
      message: message ?? this.message,
      offers: offers ?? this.offers,
      subscriptedPlan: subscriptedPlan ?? this.subscriptedPlan,
      userActivePlans: userActivePlans ?? this.userActivePlans,
      userActivePlan: userActivePlan ?? this.userActivePlan,
    );
  }

  @override
  String toString() {
    return 'OfferState(status: $status, message: $message, offers: $offers, subscriptedPlan: $subscriptedPlan, userActivePlans: $userActivePlans)';
  }
}
