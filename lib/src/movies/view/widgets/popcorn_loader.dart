import 'package:flutter/material.dart';

class PopcornLoader extends StatefulWidget {
  final double size;
  const PopcornLoader({required this.size, super.key});

  @override
  State<PopcornLoader> createState() => _PopcornLoaderState();
}

class _PopcornLoaderState extends State<PopcornLoader>
    with TickerProviderStateMixin {
  late AnimationController _popcornController;
  late Animation<int> _animationPopcorn;

  @override
  void initState() {
    super.initState();

    _popcornController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationPopcorn = IntTween(begin: 1, end: 23).animate(_popcornController);

    _popcornController.repeat();
  }

  @override
  void dispose() {
    _popcornController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _popcornController,
      builder: (context, state) {
        String frame = _animationPopcorn.value.toString();
        return Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/popcorn_$frame.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
