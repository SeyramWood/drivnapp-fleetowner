import 'package:flutter/material.dart';

import '../widget/available.car.tile.dart';

class CarsAvailableBuilder extends StatefulWidget {
  const CarsAvailableBuilder({super.key});

  @override
  State<CarsAvailableBuilder> createState() => _CarsAvailableBuilderState();
}

class _CarsAvailableBuilderState extends State<CarsAvailableBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CarTile();
      },
    );
  }
}