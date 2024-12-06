part of 'homepage_bloc.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();
}

final class HomepageInitial extends HomepageState {
  @override
  List<Object> get props => [];
}

final class HomepageLoadingState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class HomepageSearchLoadedState extends HomepageState {
  final List<PantoneColor> colors;
  final WeekBannerModel weekBannerModel;
  final List<TrendyColorModel> trendyColorModels;
  final String trendyText;

  const HomepageSearchLoadedState({required this.colors, required this.weekBannerModel, required this.trendyColorModels, required this.trendyText});

  HomepageSearchLoadedState copyWith({
    List<PantoneColor>? colors,
    WeekBannerModel? weekBannerModel,
    List<TrendyColorModel>? trendyColorModels,
    String? trendyText
  }) {
    return HomepageSearchLoadedState(
      colors: colors ?? this.colors,
      weekBannerModel: weekBannerModel ?? this.weekBannerModel,
      trendyColorModels: trendyColorModels ?? this.trendyColorModels,
      trendyText: trendyText ?? this.trendyText);
  }

  @override
  List<Object?> get props => [colors, weekBannerModel, trendyColorModels, trendyText];
}

final class HomepageUiLoadedState extends HomepageState {
  final WeekBannerModel weekBannerModel;
  final List<TrendyColorModel> trendyColorModels;
  final String trendyText;

  const HomepageUiLoadedState({required this.weekBannerModel, required this.trendyColorModels, required this.trendyText});
  @override
  List<Object?> get props => [weekBannerModel, trendyColorModels, trendyText];
}

final class HomepageErrorState extends HomepageState {
  final String errorMessage;

  const HomepageErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}