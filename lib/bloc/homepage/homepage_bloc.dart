import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantone_book/model/trendy_color_model.dart';
import 'package:pantone_book/model/week_banner_model.dart';
import 'package:pantone_book/services/pantone_database/app_db.dart';
import 'package:pantone_book/services/repositories/homepage_repository/homepage_repository.dart';

import '../../model/pantone_model.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<HomepageInitialEvent>((event, emit) async {
      try {
        final HomepageRepository repository = HomepageRepository();
        WeekBannerModel weekBannerModel = await repository.fetchWeekBannerData();
        List<TrendyColorModel> trendyColorModels = await repository.fetchTrendyColorData();
        String trendyText = await repository.fetchTrendyText();
        emit(HomepageUiLoadedState(weekBannerModel: weekBannerModel, trendyColorModels: trendyColorModels, trendyText: trendyText));
      } catch(error) {
        emit(HomepageErrorState(error.toString()));
      }
    });

    on<HomepageSearchTriggerEvent>((event, emit) async {
      try {
        if (event.query.length < 2) {
          emit(HomepageUiLoadedState(weekBannerModel: event.weekBannerModel, trendyColorModels: event.trendyColorModels, trendyText: event.trendyText));
        } else {
          emit(HomepageLoadingState());
          final List<PantoneColor> allColors = await AppDb.instance.fetchAllPantoneColors();
          final List<PantoneColor> filteredColors = allColors.where((color) =>
          color.colorName.toLowerCase().contains(event.query.toLowerCase()) ||
              color.pantoneCode.toLowerCase().contains(event.query.toLowerCase())
          ).toList();
          emit(HomepageSearchLoadedState(colors: filteredColors, weekBannerModel: event.weekBannerModel, trendyColorModels: event.trendyColorModels, trendyText: event.trendyText));
        }
      } catch(error) {
        emit(HomepageErrorState(error.toString()));
      }
    });
  }
}
