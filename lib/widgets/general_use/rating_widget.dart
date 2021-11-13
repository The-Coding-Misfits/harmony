import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final double rating;
  final double size;

  @override
  _RatingWidgetState createState() => _RatingWidgetState();

  const RatingWidget(this.rating, this.size);
}

class _RatingWidgetState extends State<RatingWidget> {

  late Color activeColor;
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.rating;
    activeColor = widget.rating > 3 ? const Color(0xff00CA9D) : Colors.red;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RatingBall(activeColor, widget.size, rating - 0),
        _RatingBall(activeColor, widget.size, rating - 1),
        _RatingBall(activeColor, widget.size, rating - 2),
        _RatingBall(activeColor, widget.size, rating - 3),
        _RatingBall(activeColor, widget.size, rating - 4),
      ]
    );
  }
}


//not the best practice but never gonna use elsewhere so we can keep it private imo
class _RatingBall extends StatelessWidget {
  late final _FILL_BALL _fillBall;
  final Color activeColor;
  final double size;
  static const IconData icon = Icons.circle;

  static const Color inactiveColor = Colors.grey;

  _RatingBall(this.activeColor, this.size, double ratingOffset){
    if(ratingOffset < 0.5){
      _fillBall = _FILL_BALL.empty;
    } else if( ratingOffset < 1){
      _fillBall = _FILL_BALL.half;
    } else {
      _fillBall = _FILL_BALL.full;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_fillBall){
      case _FILL_BALL.empty: {
        return Icon(icon, color: inactiveColor, size: size);
      }
      case _FILL_BALL.half: {
        return _HalfFilledIcon(icon: icon, size: size, color: activeColor);
      }
      case _FILL_BALL.full: {
        return Icon(icon, color: activeColor, size: size);
      }
    }
  }


}


//well this is just too complex to be in RatingBall class so
class _HalfFilledIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  static const Color inactiveColor = Colors.grey;

  const _HalfFilledIcon({required this.icon, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: const [0, 0.5, 0.5],
          colors: [color, color, color.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon, size: size, color: inactiveColor),
      ),
    );
  }
}

//still just here so private
enum _FILL_BALL{
  empty,
  half,
  full
}