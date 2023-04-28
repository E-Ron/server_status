import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static const _animationDuration = Duration(minutes: 5);

  late Animation<double> _animationBefore;
  late Animation<double> _animationAfter;

  final Animatable<double> _tweenBefore = Tween(begin: -1, end: 0);
  final Animatable<double> _tweenAfter = Tween(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _animationBefore = _animationController.drive(_tweenBefore);
    _animationAfter = _animationController.drive(_tweenAfter);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          children: [
            _BackgroundAnimationItem(
              animation: _animationBefore,
            ),
            _BackgroundAnimationItem(
              animation: _animationAfter,
            ),
          ],
        ),
      ),
      widget.child
    ]);
  }
}

class _BackgroundAnimationItem extends StatelessWidget {
  const _BackgroundAnimationItem({
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final double backgroundHeight =
        MediaQuery.of(context).size.height - kToolbarHeight * 2;
    return Positioned(
      left: animation.value * backgroundHeight * 4,
      child: Opacity(
        opacity: 0.5,
        child: Image.asset(
          height: backgroundHeight,
          'assets/images/cloud_day.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
