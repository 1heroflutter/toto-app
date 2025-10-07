part of 'assistant_bloc.dart';

abstract class AssistantState extends Equatable {
  final List<Message> messages;

  const AssistantState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class AssistantInitial extends AssistantState {
  const AssistantInitial() : super(messages: const []);
}

class AssistantLoading extends AssistantState {
  const AssistantLoading({required super.messages});
}

class AssistantSuccess extends AssistantState {
  const AssistantSuccess({required super.messages});
}

class AssistantError extends AssistantState {
  final String error;

  const AssistantError({required super.messages, required this.error});

  @override
  List<Object> get props => [error, ...super.props];
}