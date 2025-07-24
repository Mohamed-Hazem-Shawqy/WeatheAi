import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:weather_ai/core/utils/colors.dart';
import 'package:weather_ai/features/home/presentation/view_model/cubit/home_cubit.dart';

class HorizontialCalender extends StatefulWidget {
  const HorizontialCalender({super.key});

  @override
  State<HorizontialCalender> createState() => _HorizontialCalenderState();
}

class _HorizontialCalenderState extends State<HorizontialCalender> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return HorizontalWeekCalendar(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      showNavigationButtons: false,
      monthColor: AppColors.blue,
      activeBackgroundColor: AppColors.blue,
      initialDate: DateTime.now(),
      minDate: DateTime.now().subtract(const Duration(days: 3)),
      maxDate: DateTime.now().add(const Duration(days: 4)),
      onDateChange: (date) {
        final cubit = context.read<HomeCubit>();
        cubit.selectedDate = DateTime(
          date.year,
          date.month,
          date.day,
        );
        cubit.changeSelectedDate();
      },
    );
  }
}
