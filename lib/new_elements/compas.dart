import 'package:flutter/material.dart';

class CompassWidget extends StatefulWidget {
  const CompassWidget({super.key, required this.numero});

  final int numero;

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.numero}');
  }
}
