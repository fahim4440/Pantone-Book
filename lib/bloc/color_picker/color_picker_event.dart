part of 'color_picker_bloc.dart';

sealed class ColorPickerEvent extends Equatable {
  const ColorPickerEvent();
}

// class CameraImageSelectedEvent extends ColorPickerEvent {
//   final File image;
//   const CameraImageSelectedEvent(this.image);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [image];
// }
//
// class GalleryImageSelectedEvent extends ColorPickerEvent {
//   final File image;
//
//   const GalleryImageSelectedEvent(this.image);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [image];
// }

class ColorPickedEvent extends ColorPickerEvent {
  final File image;
  final Offset position;
  final ScrollController scrollController;
  final BuildContext context;

  const ColorPickedEvent(this.image, this.position, this.scrollController, this.context);

  @override
  List<Object?> get props => [image, position, scrollController, context];
}
