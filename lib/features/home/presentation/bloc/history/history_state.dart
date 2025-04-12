// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transcation_app/features/home/data/models/active_plans_response.dart';
import 'package:transcation_app/features/home/data/models/transaction_history_response.dart';

enum HistoryStatus {
  initial,
  loading,
  success,
  failure,
}

class HistoryState {
  final HistoryStatus status;
  final TransactionHistoryResponse? history;
  final String? errorMessage;
  final Map<int, ActivePlan> planDetails; // Add this field

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.history,
    this.errorMessage,
    this.planDetails = const {}, // Initialize empty map
  });

  HistoryState copyWith({
    HistoryStatus? status,
    TransactionHistoryResponse? history,
    String? errorMessage,
    Map<int, ActivePlan>? planDetails,
  }) {
    return HistoryState(
      status: status ?? this.status,
      history: history ?? this.history,
      errorMessage: errorMessage,
      planDetails: planDetails ?? this.planDetails,
    );
  }
}
extension HistoryStateX on HistoryState {
  bool get isLoading => status == HistoryStatus.loading;
  bool get isSuccess => status == HistoryStatus.success;
  bool get isFailure => status == HistoryStatus.failure;
  bool get isInitial => status == HistoryStatus.initial;
}