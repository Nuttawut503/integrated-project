part of 'image_uploads_bloc.dart';

abstract class ImageUploadsEvent extends Equatable {
  const ImageUploadsEvent();
  @override
  List<Object> get props => [];
}

class PickImage extends ImageUploadsEvent {
  final ImageSource source;

  PickImage({this.source});
  @override
  List<Object> get props => [source];
}

class CropImage extends ImageUploadsEvent {}

class ClearImage extends ImageUploadsEvent {}

class Next extends ImageUploadsEvent {}
