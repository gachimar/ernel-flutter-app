import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  // double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<UiModel>(
      builder: (context, ui, child) => Slider(
        value: ui.getScale(),
        max: 2,
        divisions: 40,
        label: ui.getScale().toString(),
        onChanged: (double value) {
          setState(() {
            ui.setScale(value);
          });
        },
      ),
    );
  }
}
