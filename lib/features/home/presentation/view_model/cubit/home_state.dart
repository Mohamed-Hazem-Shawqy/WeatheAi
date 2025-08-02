part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<WeatherModel> weathers;
  final int? index;

  HomeSuccess({this.index, required this.weathers});
}

final class HomeFailuer extends HomeState {
  final ServerFailure errMessage;

  HomeFailuer({required this.errMessage});
}


