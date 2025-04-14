// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';

enum MyPlansStatus { initial, loading, success, error,successGetPlanDetails }
extension MyPlansStateX on MyPlansState {
  bool get isInitial => status == MyPlansStatus.initial;
  bool get isLoading => status == MyPlansStatus.loading;
  bool get isSuccess => status == MyPlansStatus.success;
  bool get isError => status == MyPlansStatus.error;
  bool get isSuccessGetPlanDetails => status == MyPlansStatus.successGetPlanDetails;
}
class MyPlansState {
  final MyPlansStatus status;
    final ActivePlan? userActivePlan;
  final List<ActivePlan>? activePlans;
  final String? errorMessage;

  const MyPlansState({
    required this.status,
    this.userActivePlan,
    this.activePlans = const [],
    this.errorMessage,
  });

  const MyPlansState.initial()
      : this(
          status: MyPlansStatus.initial,
          activePlans: const [],
          errorMessage: null,
        );

  MyPlansState copyWith({
    MyPlansStatus? status,
    ActivePlan? userActivePlan,
    List<ActivePlan>? activePlans,
    String? errorMessage,
  }) {
    return MyPlansState(
      status: status ?? this.status,
      userActivePlan: userActivePlan ?? this.userActivePlan,
      activePlans: activePlans ?? this.activePlans,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
