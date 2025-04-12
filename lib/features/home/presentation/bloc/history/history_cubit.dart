import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';
import 'history_state.dart';
@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final MainRepository _repository;

  HistoryCubit(this._repository) : super(const HistoryState());

  Future<void> getTransactionHistory(String token) async {
    emit(state.copyWith(status: HistoryStatus.loading));

    final result = await _repository.getLastTranscations(token);

    result.fold(
      (failure) => emit(state.copyWith(
        status: HistoryStatus.failure,
        errorMessage: failure.message,
      )),
      (history) async {
        // Fetch plan details for each subscription
        final subscriptionsWithDetails = await Future.wait(
          history.subscriptions.map((subscription) async {
            final planResult = await _repository.getPlanReuslt(
              token,
              subscription.planId.toString(),
            );
            return planResult.fold(
              (failure) => null,
              (plan) => (subscription, plan),
            );
          }),
        );

        emit(state.copyWith(
          status: HistoryStatus.success,
          history: history,
          planDetails: Map.fromEntries(
            subscriptionsWithDetails
                .where((element) => element != null)
                .map((e) => MapEntry(e!.$1.planId, e.$2)),
          ),
        ));
      },
    );
  }
}