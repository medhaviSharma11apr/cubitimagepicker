part of 'image_cubit.dart';

@immutable
class ImageState {}

 class ImageInitialState extends ImageState {}

class ImageLoadedState extends ImageState {
  final String imagePath;

  ImageLoadedState(this.imagePath);

}

class ImageErrorState extends ImageState {
  final String errorMessage;

  ImageErrorState(this.errorMessage);
}


