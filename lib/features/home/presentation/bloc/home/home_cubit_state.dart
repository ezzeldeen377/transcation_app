// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  successGetUser,
  successGetplanes,
  sucesssGetNotifcations,
  successGetUserActivePlans,
  subscribePlan,
  successCheckPlans,
  successGetTranscation,
  failure,
}
extension HomeStateX on HomeState {
  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.successGetUser;
  bool get isFailure => status == HomeStatus.failure;
  bool get isSuccessGetPlanes => status == HomeStatus.successGetplanes;
  bool get isSuccessGetNotifcations => status == HomeStatus.sucesssGetNotifcations;
  bool get isSuccessGetUserActivePlans => status == HomeStatus.successGetUserActivePlans;
  bool get isSubscribePlan => status == HomeStatus.subscribePlan;
  bool get isSuccessCheckPlans => status == HomeStatus.successCheckPlans;
  bool get isSuccessGetTranscation => status == HomeStatus.successGetTranscation;
}
class HomeState {
  final HomeStatus status;
  final String? message;
  final User? user;
  final List<Plan>? plans;
  final List<Notification>? notifications;
  final List<ActivePlan>? userActivePlans;
  final SubscriptedPlan? subscriptedPlan;
    final TransactionHistoryResponse? history;
  final Map<int, ActivePlan>? planDetails;
  HomeState({
    required this.status,
    this.message,
    this.user,
    this.plans,
    this.notifications,
    this.userActivePlans,
    this.subscriptedPlan,
    this.history,
     this.planDetails,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    User? user,
    List<Plan>? plans,
    List<Notification>? notifications,
    List<ActivePlan>? userActivePlans,
    SubscriptedPlan? subscriptedPlan,
    TransactionHistoryResponse? history,
    Map<int, ActivePlan>? planDetails,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      plans: plans ?? this.plans,
      notifications: notifications ?? this.notifications,
      userActivePlans: userActivePlans ?? this.userActivePlans,
      subscriptedPlan: subscriptedPlan ?? this.subscriptedPlan,
      history: history ?? this.history,
      planDetails: planDetails ?? this.planDetails,
    );
  }

  @override
  String toString() {
    return 'HomeState(status: $status, message: $message, user: $user, plans: $plans, notifications: $notifications, userActivePlans: $userActivePlans, subscriptedPlan: $subscriptedPlan, history: $history, planDetails: $planDetails)';
  }
}
