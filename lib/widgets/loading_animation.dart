import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;

  late Animation<double> _curve;
  late List<TweenSequenceItem<double>> _tweenSequenceInOut;

  double maxHeight = 60;

  Animatable<double> tweenIn = Tween(begin: 1.0, end: 2.0);
  Animatable<double> tweenOut = Tween(begin: 2.0, end: 1.0);
  Animatable<double> tweenStart = ConstantTween(1.0);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _tweenSequenceInOut = [
      TweenSequenceItem(tween: tweenIn, weight: 1),
      TweenSequenceItem(tween: tweenOut, weight: 1),
    ];

    _scaleAnimation1 = TweenSequence([
      ..._tweenSequenceInOut,
      TweenSequenceItem(tween: tweenStart, weight: 6),
    ]).animate(_curve);
    _scaleAnimation2 = TweenSequence([
      TweenSequenceItem(tween: tweenStart, weight: 2),
      ..._tweenSequenceInOut,
      TweenSequenceItem(tween: tweenStart, weight: 2),
      ..._tweenSequenceInOut,
    ]).animate(_curve);
    _scaleAnimation3 = TweenSequence([
      TweenSequenceItem(tween: tweenStart, weight: 4),
      ..._tweenSequenceInOut,
      TweenSequenceItem(tween: tweenStart, weight: 2),
    ]).animate(_curve);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return LoadingAnimationItem(scaleAnimation: _scaleAnimation1);
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return LoadingAnimationItem(scaleAnimation: _scaleAnimation2);
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return LoadingAnimationItem(scaleAnimation: _scaleAnimation3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingAnimationItem extends StatelessWidget {
  const LoadingAnimationItem({super.key, required this.scaleAnimation});

  final Animation scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 5,
          color: const Color.fromRGBO(128, 128, 128, 1),
        ),
        color: Colors.transparent,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: scaleAnimation.value * 30,
      width: 30,
    );
  }
}
