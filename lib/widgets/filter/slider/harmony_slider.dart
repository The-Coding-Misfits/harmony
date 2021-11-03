import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/slider/rounded_rectangular_thumb.dart';

class HarmonySlider extends StatefulWidget {
  final Function(double) onValueChanged;
  final int minValue;
  final int maxValue;
  final int startingValue;

  HarmonySlider(this.onValueChanged, this.minValue, this.maxValue, this.startingValue);

  @override
  _HarmonySliderState createState() => _HarmonySliderState();

}

class _HarmonySliderState extends State<HarmonySlider> {

  final Color stationaryActiveTrack = const Color(0xFF5F5D70);
  final Color inactiveTrack = const Color(0xFFdfe2e5);
  final Color movingActiveTrack = const Color(0xFF00CA9D);

  Color currActiveTrackColor = const Color(0xFF5F5D70); //which is stationary active track


  late double _currValue;
  @override
  void initState() {
    super.initState();
    _currValue = widget.startingValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape:CustomSliderThumbRect(
            thumbRadius: 10 * .4,
            thumbHeight: 35,
            min: widget.minValue,
            max: widget.maxValue,
        ),
        thumbColor: Colors.redAccent,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _currValue,
        min: widget.minValue.toDouble(),
        max: widget.maxValue.toDouble(),
        divisions: 10,
        label: '$_currValue',
        onChanged: (value) {
          setState(
                () {
                  _currValue = value;
            },
          );
        },
      ),
    );
  }
}
/*return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: currActiveTrackColor,
        inactiveTrackColor: inactiveTrack,
        valueIndicatorTextStyle: TextStyle(
          decoration:
        )
      ),
      child: Slider(
        value: _currValue,
        min: widget.minValue,
        max: widget.maxValue,
        onChangeStart: (_){
          setState(() {
            currActiveTrackColor = movingActiveTrack;
          });
        },
        onChangeEnd: (_){
          setState(() {
            currActiveTrackColor = stationaryActiveTrack;
          });
        },
        onChanged: (double value) {
          setState(() {
            _currValue = value;
            widget.onValueChanged(value);
          });
        },
        label: "$_currValue" ,
      ),
    );*/