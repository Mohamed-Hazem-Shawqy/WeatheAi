import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather_ai/core/utils/colors.dart';

class PrecentIndecator extends StatelessWidget {
  const PrecentIndecator({super.key, required this.temp});
  final double temp;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: (100 - temp) / 100,
      center: Text('$temp'),
      progressColor: AppColors.blue,
    );
  }
}
