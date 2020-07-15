import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

part 'image_uploads_event.dart';
part 'image_uploads_state.dart';

class ImageUploadsBloc extends Bloc<ImageUploadsEvent, ImageUploadsState> {
  ImageUploadsBloc() : super(ImageUploadsInitial());

  @override
  Stream<ImageUploadsState> mapEventToState(
    ImageUploadsEvent event,
  ) async* {
    if (event is CropImage) {
      yield* _cropImage((state as PickedImage).imageFile);
    } else if (event is PickImage) {
      yield* _pickImage(event.source);
    } else if (event is ClearImage) {
      yield ClearedImage(imageFile: null);
    }
  }

  Future getImage() async {
    final selected = await ImagePicker().getImage(source: ImageSource.camera);
    return selected;
  }

  Stream<ImageUploadsState> _pickImage(ImageSource source) async* {
    print('haha');
    final selected = await ImagePicker().getImage(source: source);
    print('yes');
    yield PickedImage(imageFile: selected);
  }

  Stream<ImageUploadsState> _cropImage(state) async* {
    File cropped = await ImageCropper.cropImage(
        sourcePath: state.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.purple,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Crop It'));
    yield CropedImage(imageFile: cropped ?? state);
  }
}
