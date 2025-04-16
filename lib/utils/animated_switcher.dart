import 'package:flutter/material.dart';

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const AnimatedIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedIndexedStack> createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack> {
  late int _prevIndex;

  @override
  void initState() {
    _prevIndex = widget.index;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _prevIndex = oldWidget.index;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isForward = widget.index > _prevIndex;
    final child = widget.children[widget.index];


    return AnimatedSwitcher(
      duration: widget.duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetTween = Tween<Offset>(
          begin: isForward ? const Offset(-1, 0) : const Offset(1, 0),
          end: Offset.zero,
        );
        return SlideTransition(
          position: offsetTween.animate(animation),
          child: child,
        );
      },
      child: KeyedSubtree(
        key: ValueKey<int>(widget.index),
        child: child,
      ),
    );
  }
}

