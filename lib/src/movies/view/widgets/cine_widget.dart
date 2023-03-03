import 'package:flutter/material.dart';

class CineWidget extends StatefulWidget {
  final String? backdropPath;
  const CineWidget({this.backdropPath, super.key});

  @override
  State<CineWidget> createState() => _CineWidgetState();
}

class _CineWidgetState extends State<CineWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: ((context, child) {
        return SizedBox(
          height: size.height / 2,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    color: const Color(0xFF0d7cd4),
                  )),
              Positioned(
                left: size.height * 0.07,
                top: size.height * 0.1,
                child: (widget.backdropPath == null)
                    ? Container(
                        width: size.width / 1.4,
                        height: size.height / 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('assets/images/popcorn_1.png'),
                              fit: BoxFit.fitWidth),
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                    strokeAlign: BorderSide.strokeAlignCenter),
                                color: Colors.transparent),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      )
                    : Container(
                        width: size.width / 1.4,
                        height: size.height / 4,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://image.tmdb.org/t/p/w780/${widget.backdropPath}'),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                    strokeAlign: BorderSide.strokeAlignCenter),
                                color: Colors.transparent),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ),
                        )),
              ),
              Positioned(
                  top: -size.height * 0.31,
                  left: -size.height * 0.27,
                  child: Transform.translate(
                      offset: Offset(0, _animation.value * 100),
                      child: Image.asset(
                        'assets/images/silhouette_top.png',
                        scale: 2.5,
                      ))),
              Positioned(
                  left: -size.height * 0.33,
                  top: -size.height * 0.2,
                  child: Transform.translate(
                      offset: Offset(_animation.value * 100, 0),
                      child: Image.asset(
                        'assets/images/silhouette_left_top.png',
                        scale: 2.5,
                      ))),
              Positioned(
                  right: -size.height * 0.32,
                  top: -size.height * 0.2,
                  child: Transform.translate(
                      offset: Offset(-_animation.value * 100, 0),
                      child: Image.asset(
                        'assets/images/silhouette_right_top.png',
                        scale: 2.5,
                      ))),
              Positioned(
                  left: -size.height * 0.3,
                  top: -size.height * 0.2,
                  child: Transform.translate(
                      offset: Offset(_animation.value * 70, 0),
                      child: Image.asset(
                        'assets/images/silhouette_left_bottom.png',
                        scale: 2.5,
                      ))),
              Positioned(
                  right: -size.height * 0.3,
                  top: -size.height * 0.2,
                  child: Transform.translate(
                      offset: Offset(-_animation.value * 70, 0),
                      child: Image.asset(
                        'assets/images/silhouette_right_bottom.png',
                        scale: 2.5,
                      ))),
              Positioned(
                  top: 0,
                  left: -size.width * 0.38,
                  child: Transform.translate(
                      offset: Offset(
                        0,
                        -_animation.value * 100,
                      ),
                      child: Image.asset(
                        'assets/images/silhouette_people.png',
                        scale: 2.8,
                      ))),
            ],
          ),
        );
      }),
    );
  }
}
