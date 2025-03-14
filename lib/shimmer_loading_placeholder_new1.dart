///
/// A package provides an easy way to add shimmer effect to Flutter application
///

library shimmer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ShimmerDirection { ltr, rtl, ttb, btt }

@immutable
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final Gradient gradient;
  final int loop;
  final bool enabled;
  final double borderRadius;

  const Shimmer({
    super.key,
    required this.child,
    required this.gradient,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
    this.borderRadius = 0.0,
  });

  Shimmer.fromColors({
    super.key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.borderRadius = 0.0,
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            baseColor,
            baseColor,
            highlightColor,
            baseColor,
            baseColor
          ],
          stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
        );

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..addStatusListener((status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.loop <= 0) {
          _controller.repeat();
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) => _Shimmer(
          direction: widget.direction,
          gradient: widget.gradient,
          percent: _controller.value,
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerDirection direction;
  final Gradient gradient;

  const _Shimmer({
    Widget? child,
    required this.percent,
    required this.direction,
    required this.gradient,
  }) : super(child: child);

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, direction, gradient);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  ShimmerDirection _direction;
  Gradient _gradient;
  double _percent;

  _ShimmerFilter(this._percent, this._direction, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) return;
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) return;
    _gradient = newValue;
    markNeedsPaint();
  }

  set direction(ShimmerDirection newDirection) {
    if (newDirection == _direction) return;
    _direction = newDirection;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      layer = null;
      return;
    }

    final double width = child!.size.width;
    final double height = child!.size.height;
    Rect rect;
    double dx, dy;

    switch (_direction) {
      case ShimmerDirection.rtl:
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
        break;
      case ShimmerDirection.ttb:
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
        break;
      case ShimmerDirection.btt:
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
        break;
      default:
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
        break;
    }

    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;

    context.pushLayer(layer!, super.paint, offset);
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}

///
/// A simple shimmer container for easy usage
///
class ShimmerContainer extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration period;
  final double borderRadius;
  final ShimmerDirection direction;

  const ShimmerContainer({
    super.key,
    required this.child,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.period = const Duration(milliseconds: 1500),
    this.borderRadius = 8.0,
    this.direction = ShimmerDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: period,
      borderRadius: borderRadius,
      direction: direction,
      child: child,
    );
  }
}
