import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/utils/mounted_mixin.dart';
import 'package:transcation_app/features/home/data/repositories/main_repository.dart';
import 'package:transcation_app/features/home/data/models/agent_model.dart';

part 'agent_state.dart';

@injectable
class AgentCubit extends Cubit<AgentState> with MountedCubit<AgentState> {
  final MainRepository _repository;

  AgentCubit(this._repository) : super(AgentState(status: AgentStatus.initial));

  Future<void> getAgents({required Country country}) async {
    emit(state.copyWith(
      status: AgentStatus.loading,
      selectedCountry: country,
    ));
    print("country.displayName is ${country.nameLocalized}");
    final result = await _repository.getAgents( country.nameLocalized??"");
    result.fold(
      (failure) => emit(state.copyWith(
        status: AgentStatus.failure,
        message: failure.message,
        agents: [],
      )),
      (agentResponse) => emit(state.copyWith(
        status: AgentStatus.success,
        agents: agentResponse.agents,
      )),
    );
  }
}