import 'package:flutter/material.dart';


Future<void> showAuthRevealTransition({
  required BuildContext context,
  required GlobalKey buttonKey,
  Color? color,
  Duration expandDuration = const Duration(milliseconds: 450),
  Duration fadeDuration = const Duration(milliseconds: 200),
  required VoidCallback onRevealComplete,
}) async {
  final theme = Theme.of(context);
  final revealColor = color ?? theme.colorScheme.primary;

  final renderBox = buttonKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) {
    onRevealComplete();
    return;
  }

  final buttonSize = renderBox.size;
  final buttonPosition = renderBox.localToGlobal(Offset.zero);
  final center = buttonPosition +
      Offset(buttonSize.width / 2, buttonSize.height / 2);

  final screenSize = MediaQuery.of(context).size;
  final corners = [
    Offset.zero,
    Offset(screenSize.width, 0),
    Offset(0, screenSize.height),
    Offset(screenSize.width, screenSize.height),
  ];
  final maxRadius = corners
      .map((c) => (c - center).distance)
      .reduce((a, b) => a > b ? a : b);

  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _RevealOverlay(
      center: center,
      maxRadius: maxRadius,
      color: revealColor,
      expandDuration: expandDuration,
      fadeDuration: fadeDuration,
      onExpandComplete: onRevealComplete,
      onFadeComplete: entry.remove,
    ),
  );
  overlay.insert(entry);
}

class _RevealOverlay extends StatefulWidget {
  final Offset center;
  final double maxRadius;
  final Color color;
  final Duration expandDuration;
  final Duration fadeDuration;
  final VoidCallback onExpandComplete;
  final VoidCallback onFadeComplete;

  const _RevealOverlay({
    required this.center,
    required this.maxRadius,
    required this.color,
    required this.expandDuration,
    required this.fadeDuration,
    required this.onExpandComplete,
    required this.onFadeComplete,
  });

  @override
  State<_RevealOverlay> createState() => _RevealOverlayState();
}

class _RevealOverlayState extends State<_RevealOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _expand;
  late final AnimationController _fade;

  @override
  void initState() {
    super.initState();
    _expand = AnimationController(vsync: this, duration: widget.expandDuration);
    _fade = AnimationController(
      vsync: this,
      duration: widget.fadeDuration,
      value: 1.0,
    );

    _expand.addStatusListener((status) async {
      if (status != AnimationStatus.completed) return;
      widget.onExpandComplete();
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
      await _fade.reverse();
      widget.onFadeComplete();
    });

    _expand.forward();
  }

  @override
  void dispose() {
    _expand.dispose();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: Listenable.merge([_expand, _fade]),
          builder: (context, _) {
            return Opacity(
              opacity: _fade.value,
              child: CustomPaint(
                painter: _RevealPainter(
                  center: widget.center,
                  radius: widget.maxRadius * _expand.value,
                  color: widget.color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RevealPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  _RevealPainter({
    required this.center,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(center, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_RevealPainter old) =>
      old.radius != radius || old.center != center || old.color != color;
}