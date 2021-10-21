import 'package:flutter/material.dart';

class HarmonySlider extends StatefulWidget {
  final Function(double) onValueChanged;
  final double minValue;
  final double maxValue;
  final double startingValue;

  HarmonySlider(this.onValueChanged, this.minValue, this.maxValue, this.startingValue);

  @override
  _HarmonySliderState createState() => _HarmonySliderState();

}

class _HarmonySliderState extends State<HarmonySlider> {

  late double _currValue;
  @override
  void initState() {
    super.initState();
    _currValue = widget.startingValue;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currValue,
      min: widget.minValue,
      max: widget.maxValue,
      onChanged: (double value) {
        setState(() {
          _currValue = value;
          widget.onValueChanged(value);
        });
      },
    );
  }
}
