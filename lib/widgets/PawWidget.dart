import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class PawWidget extends StatelessWidget {
  final double size;
  final double angle;
  final double opacity;

  const PawWidget({
    @required this.size,
    @required this.angle,
    @required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      child: Transform.rotate(
        angle: math.pi / angle,
        child: Image(
          width: size,
          height: size,
          image: AssetImage('images/paw.png'),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
    );
  }
}
