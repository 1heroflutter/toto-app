import 'package:flutter/material.dart';
class AiMessageBubble extends StatelessWidget {
  final String message;
  final bool isLoading;

  const AiMessageBubble({
    super.key,
    required this.message,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSecondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: isLoading
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
                  (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: AnimatedDot(delay: i * 200),
              ),
            ),
          )
              : Text(
            message,
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedDot extends StatefulWidget {
  final int delay;
  const AnimatedDot({super.key, required this.delay});

  @override
  State<AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _opacity = Tween(begin: 0.3, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        widget.delay / 1000,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: const Text(
        "•",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
