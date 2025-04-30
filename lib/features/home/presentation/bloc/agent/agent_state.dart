// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'agent_cubit.dart';

enum AgentStatus {
  initial,
  loading,
  success,
  failure,
}

extension AgentStateX on AgentState {
  bool get isInitial => status == AgentStatus.initial;
  bool get isLoading => status == AgentStatus.loading;
  bool get isSuccess => status == AgentStatus.success;
  bool get isFailure => status == AgentStatus.failure;
}

class AgentState {
  final AgentStatus status;
  final String? message;
  final Country? selectedCountry;
  final List<Agent> agents;

  AgentState({
    required this.status,
    this.message,
     this.selectedCountry,
    this.agents = const [],
  });

  AgentState copyWith({
    AgentStatus? status,
    String? message,
    Country? selectedCountry,
    List<Agent>? agents,
  }) {
    return AgentState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      agents: agents ?? this.agents,
    );
  }

  @override
  String toString() {
    return 'AgentState(status: $status, message: $message, selectedCountry: $selectedCountry, agents: $agents)';
  }
}
