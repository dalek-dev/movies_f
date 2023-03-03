import 'package:flutter/material.dart';

class CardPoster extends StatelessWidget {
  final double height;
  final double width;
  final double borderSize;
  final DecorationImage? decorationImage;
  final Widget? child;

  const CardPoster(
      {this.child,
      this.borderSize = 16,
      this.height = 300,
      this.width = 200,
      this.decorationImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderSize)),
        image: decorationImage,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          )
        ],
      ),
      child: child,
    );
  }
}
