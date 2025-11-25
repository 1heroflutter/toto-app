import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.background,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: widget.controller,
              maxLines: 1,
              decoration: InputDecoration(
                fillColor: theme.colorScheme.background,
                hintText: "Write your message",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none
              ),
              onFieldSubmitted: (text) {
                widget.onSend(text);
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {
                widget.onSend(widget.controller.text);
            },
          ),
        ],
      ),
    );
  }
}