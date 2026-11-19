import 'package:flutter/material.dart';

/// A small animated circular loader shown inside buttons during async operations.
/// Preserves the button's existing color — just pass [color] to match.
class AppButtonLoader extends StatefulWidget {
  /// Size of the loader (default 20).
  final double size;

  /// Color of the spinning arc (default white — suitable for colored buttons).
  final Color color;

  /// Stroke width of the arc (default 2.5).
  final double strokeWidth;

  const AppButtonLoader({
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.strokeWidth = 2.5,
  });

  @override
  State<AppButtonLoader> createState() => _AppButtonLoaderState();
}

class _AppButtonLoaderState extends State<AppButtonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CircularProgressIndicator(
            value: null, // indeterminate
            strokeWidth: widget.strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
          );
        },
      ),
    );
  }
}
