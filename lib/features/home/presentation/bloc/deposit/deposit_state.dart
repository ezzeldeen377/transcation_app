part of 'deposit_cubit.dart';

enum DepositStatus {
  initial,
  loading,
  success,
  failure,
}

extension DepositStateX on DepositState {
  bool get isInitial => status == DepositStatus.initial;
  bool get isLoading => status == DepositStatus.loading;
  bool get isSuccess => status == DepositStatus.success;
  bool get isFailure => status == DepositStatus.failure;
}

class DepositState {
  final DepositStatus status;
  final String? message;
  final int? balance;

  DepositState({
    required this.status,
    this.message,
    this.balance,
  });

  DepositState copyWith({
    DepositStatus? status,
    String? message,
    int? balance,
  }) {
    return DepositState(
      status: status ?? this.status,
      message: message ?? this.message,
      balance: balance ?? this.balance,
    );
  }

  @override
  String toString() {
    return 'DepositState(status: $status, message: $message, balance: $balance)';
  }
}