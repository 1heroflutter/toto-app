import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/core/config/assets/app_images.dart';
import 'package:mytodoapp/service_locator.dart';
import '../bloc/assistant_bloc.dart';
import '../widgets/ai_message_bubble.dart';
import '../widgets/user_message_bubble.dart';
import '../widgets/chat_input_bar.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => sl<AssistantBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(AppImages.aiAssistant),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('AI Assistant'),
              const Text(
                'Online',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: theme.colorScheme.background,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Chat Messages
            Expanded(
              child: BlocBuilder<AssistantBloc, AssistantState>(
                builder: (context, state) {
                  final bloc = context.read<AssistantBloc>();
                  final messages = bloc.messages;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return Container(
                    color: theme.colorScheme.surface,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          messages.length + (state is AssistantLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (state is AssistantLoading &&
                            index == messages.length) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: AiMessageBubble(
                              message: "",
                              isLoading: true,
                            ),
                          );
                        }

                        final message = messages[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Align(
                            alignment:
                                message.isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child:
                                message.isUser
                                    ? UserMessageBubble(message: message.text)
                                    : AiMessageBubble(message: message.text),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            BlocBuilder<AssistantBloc, AssistantState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  color: Colors.transparent,
                  child: ChatInputBar(
                    controller: _messageController,
                    onSend: (String text) {
                      if (text.trim().isNotEmpty) {
                        context.read<AssistantBloc>().add(
                          SendMessageEvent(text.trim()),
                        );
                        _messageController.clear();
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
