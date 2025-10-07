import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mytodoapp/common/helper/ai_command_parser.dart';
import 'package:mytodoapp/domain/assistant/entities/assistant_action.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/add_task.dart';
import 'package:mytodoapp/domain/task/usecase/delete_task.dart';
import 'package:mytodoapp/domain/task/usecase/isDone_task.dart';
import 'package:mytodoapp/domain/task/usecase/update_task.dart';
import 'package:mytodoapp/service_locator.dart' show sl;

import '../../../domain/assistant/entities/message.dart';
import '../../../domain/assistant/usecases/send_message_usecase.dart';

part 'assistant_event.dart';

part 'assistant_state.dart';

class AssistantBloc extends Bloc<AssistantEvent, AssistantState> {
  final SendMessageUseCase sendMessageUseCase;
  final AiCommandParser parser;
  final List<Message> _messages = [
    const Message(text: "Hello, how can I help you?", isUser: false),
  ];

  AssistantBloc({
    required this.sendMessageUseCase,
    required this.parser,
  }) : super(AssistantInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  List<Message> get messages => _messages;

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<AssistantState> emit,
  ) async {
    // Add user message
    _messages.add(Message(text: event.message, isUser: true));
    emit(AssistantSuccess(messages: List.of(_messages)));

    try {
      emit(AssistantLoading(messages: List.of(_messages)));
      final response = await sendMessageUseCase(params: event.message);
      final action = parser.parse(response);
      String reply;
      if (action != null) {
        reply = await _handleAction(action);
      } else {
        reply = response;
      }
      _messages.add(Message(text: reply, isUser: false));
      emit(AssistantSuccess(messages: List.of(_messages)));
    } catch (e) {
      emit(AssistantError(messages: List.of(_messages), error: e.toString()));
    }
  }

  Future<String> _handleAction(AiAction action) async {
    switch (action.name) {
      case 'add_task':
        final task = TaskEntity(
          title: action.arguments["title"],
          content: action.arguments['content'] ?? '',
          date:
              action.arguments['date'] != null
                  ? DateTime.parse(action.arguments['date'])
                  : null,
          priority: action.arguments['priority'],
        );
        final result = await sl<AddTaskUseCase>().call(params: task);
        return result.fold(
              (e) => "Lỗi khi thêm task: $e",
              (_) => "Đã thêm công việc '${task.title}'.",
        );
      case 'is_done':
        final id = action.arguments['id'];
        final done = action.arguments['isDone'] ?? true;
        final result = await sl<IsDoneTaskUseCase>().call(params: id, isDone: done);
        return result.fold(
          (e) => "Lỗi khi cập nhật trạng thái: $e",
          (r) => done ? "Đã đánh dấu hoàn thành." : "Đã bỏ hoàn thành",
        );
      case 'delete_task':
        final id = action.arguments['id'];
        final result = await sl<DeleteTaskUseCase>().call(params: id);
        return result.fold(
              (e) => "Lỗi khi xoá task: $e",
              (_) => "Đã xoá công việc thành công.",
        );
        default:
          return "Xin lỗi, mình chưa hiểu yêu cầu : ${action.name}";
    }
  }
}
