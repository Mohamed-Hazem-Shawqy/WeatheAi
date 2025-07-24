import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_ai/core/Api/api_error_handeler.dart';
import 'package:weather_ai/core/Api/end_points.dart';
import 'package:weather_ai/features/home/data/model/model.dart';
import 'package:weather_ai/features/home/data/repo/repo_impl.dart';
import 'package:weather_ai/features/home/data/data_source/data_source.dart';
import 'package:weather_ai/features/home/domian/entity/ai_logic.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final RepoImpl repoImpl = RepoImpl(
    datasource: Datasource(dio: Dio()),
  );
  late AiLogic aiLogic;
  DateTime now = DateTime.now();
  DateTime nowPlus1 = DateTime.now().add(const Duration(days: 1));
  DateTime nowPlus2 = DateTime.now().add(const Duration(days: 2));
  int index = 0;
  DateTime selectedDate = DateTime.now();
//
  void changeSelectedDate() {
    final formatter = DateFormat('yyyy-MM-dd');
    String selected = formatter.format(selectedDate);
    String today = formatter.format(now);
    String day1 = formatter.format(nowPlus1);
    String day2 = formatter.format(nowPlus2);
    if (selected == today) {
      index = 0;
    } else if (selected == day1) {
      index = 1;
    } else if (selected == day2) {
      index = 2;
    } else {
      index = 0;
    }

    final currentState = state;
    if (currentState is HomeSuccess) {
      emit(HomeSuccess(
        weathers: currentState.weathers,
        index: index,
      ));
    }
  }
  //

  Future<void> aiPredict(List<WeatherModel> weather, int index) async {
    aiLogic = AiLogic(dio: Dio(), weatherModel: weather);
    final prediction = await aiLogic.predict(index);
    print("predict=$prediction");

    emit(HomeSuccess(predection: prediction, weathers: weather));
  }

  Future<void> getForecast(String country) async {
    emit(HomeLoading());

    final result = await repoImpl.getForeCast(
      EndPoints.baseUrl,
      EndPoints.foreCast,
      country,
    );

    result.fold(
      (failure) => emit(
        HomeFailuer(
          errMessage: failure,
        ),
      ),
      (weatherList) => emit(
        HomeSuccess(
          weathers: weatherList,
        ),
      ),
    );
  }
}
