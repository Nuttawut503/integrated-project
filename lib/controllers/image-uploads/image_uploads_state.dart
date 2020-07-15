part of 'image_uploads_bloc.dart';

abstract class ImageUploadsState extends Equatable {
  const ImageUploadsState();
}

class ImageUploadsInitial extends ImageUploadsState {
  @override
  List<Object> get props => [];
}

class PickedImage extends ImageUploadsState {
  final PickedFile imageFile;

  PickedImage({this.imageFile});
  @override
  List<Object> get props => [imageFile];
}

class CropedImage extends ImageUploadsState {
  final File imageFile;

  CropedImage({this.imageFile});
  @override
  List<Object> get props => [imageFile];
}

class ClearedImage extends ImageUploadsState {
  final PickedFile imageFile;
  // final File image;

  ClearedImage({this.imageFile});

  @override
  List<Object> get props => [imageFile];
}
