part of 'color_search_bloc.dart';

sealed class ColorSearchEvent extends Equatable {
  const ColorSearchEvent();
}

final class ColorSearchTriggerEvent extends ColorSearchEvent {
  final String query;

  const ColorSearchTriggerEvent(this.query);

  @override
  List<Object?> get props => [query];
}