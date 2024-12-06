part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();
}

final class HomepageSearchTriggerEvent extends HomepageEvent {
  final String query;
  final WeekBannerModel weekBannerModel;
  final List<TrendyColorModel> trendyColorModels;
  final String trendyText;

  const HomepageSearchTriggerEvent({required this.query, required this.weekBannerModel, required this.trendyColorModels, required this.trendyText});

  @override
  List<Object?> get props => [query, weekBannerModel, trendyColorModels, trendyText];
}

final class HomepageInitialEvent extends HomepageEvent {
  @override
  List<Object?> get props => [];
}