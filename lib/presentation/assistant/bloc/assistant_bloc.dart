import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mytodoapp/common/helper/ai_command_parser.dart';
import 'package:mytodoapp/domain/assistant/entities/assistant_action.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/add_task.dart';
import 'package:mytodoapp/domain/task/usecase/delete_task.dart';
import 'package:mytodoapp/domain/task/usecase/get_all_task.dart';
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
    _messages.add(Message(text: event.message, isUser: true));
    emit(AssistantSuccess(messages: List.of(_messages)));

    try {
      emit(AssistantLoading(messages: List.of(_messages)));

      final stream = await sl<GetAllTaskUseCase>().call();
      final tasksResult = await stream.first;
      List<TaskEntity> currentTasks = [];
      tasksResult.fold(
            (l) => print("Không lấy được task context: $l"),
            (r) {
          currentTasks = r;
        },
      );
      final response = await sendMessageUseCase(
        params: event.message,
        tasks: currentTasks,
      );
      final action = parser.parse(response);
      String reply;
      if (action != null) {
        reply = await _handleAction(action, currentTasks);
      } else {
        reply = response;
      }
      _messages.add(Message(text: reply, isUser: false));
      emit(AssistantSuccess(messages: List.of(_messages)));
    } catch (e) {
      emit(AssistantError(messages: List.of(_messages), error: e.toString()));
    }
  }
  Future<String> _handleAction(AiAction action, List<TaskEntity> currentTasks) async {
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
      case 'update_task':
        final String? rawId = action.arguments['id'];
        print("DEBUG: AI trả về ID: '$rawId'");

        print("DEBUG: Danh sách ID thật: ${currentTasks.map((e) => e.id).toList()}");

        if (rawId == null || rawId.isEmpty) {
          return "Lỗi: AI không xác định được công việc nào cần sửa.";
        }
        final String id = action.arguments['id'];

        // 1. Tìm task cũ trong danh sách hiện tại
        final oldTask = currentTasks.firstWhere(
              (t) => t.id == id,
          orElse: () => TaskEntity(id: id, title: '', content: ''),
        );

        // 2. Merge dữ liệu: Ưu tiên cái mới, nếu null thì giữ cái cũ
        final taskToUpdate = oldTask.copyWith(
          title: action.arguments['title'] ?? oldTask.title,
          content: action.arguments['content'] ?? oldTask.content,
          priority: action.arguments['priority'] ?? oldTask.priority,
          category: action.arguments['category'] ?? oldTask.category,
          isDone: action.arguments['isDone'] ?? oldTask.isDone,
          date: action.arguments['date'] ?? oldTask.date,
          uid: action.arguments['uid'] ?? oldTask.uid,
        );

        // 3. Gọi UseCase update
        final result = await sl<UpdateTaskUseCase>().call(params: taskToUpdate);
        return result.fold(
              (e) => "Lỗi khi cập nhật task: $e",
              (_) => "Đã cập nhật công việc thành công.",
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
