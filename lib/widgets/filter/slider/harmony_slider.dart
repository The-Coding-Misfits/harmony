import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/slider/rounded_rectangular_thumb.dart';

class HarmonyProximitySlider extends StatefulWidget {
  final Function(double) onValueChanged;
  final int minValue;
  final int maxValue;
  final double startingValue;

  const HarmonyProximitySlider(this.onValueChanged, this.minValue, this.maxValue, this.startingValue);

  @override
  _HarmonyProximitySliderState createState() => _HarmonyProximitySliderState();

}

class _HarmonyProximitySliderState extends State<HarmonyProximitySlider> {

  final Color stationaryActiveTrack = const Color(0xFF5F5D70);
  final Color inactiveTrack = const Color(0xFFdfe2e5);
  final Color movingActiveTrack = const Color(0xFF00CA9D);

  bool isActive = false;

  late double _currValue = widget.startingValue;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: isActive ? movingActiveTrack : stationaryActiveTrack,
        inactiveTrackColor: inactiveTrack,
        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape:CustomSliderThumbRect(
          thumbRadius: 10 * .4,
          thumbHeight: 50,
          min: widget.minValue,
          max: widget.maxValue,
          bgColor: Colors.white,
          isActive: isActive,
        ),
        thumbColor: const Color(0xff5F5D70),
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: const Color(0xFF5F5D70),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _currValue,
        min: widget.minValue.toDouble(),
        max: widget.maxValue.toDouble(),
        divisions: 15,
        label: '$_currValue KM',
        onChanged: (value) {
          setState(
                () {
                  _currValue = value.floorToDouble();
                  widget.onValueChanged(_currValue);
            },
          );
        },
        onChangeStart: (_){
          setState(() {
            isActive = true;
          });
        },
        onChangeEnd: (_){
          setState(() {
            isActive = false;
          });
        },
      ),
    );
  }
}