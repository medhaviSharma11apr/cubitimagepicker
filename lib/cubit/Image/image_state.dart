
part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadedState extends ImageState {
  final Uint8List imageBytes;

  ImageLoadedState({required this.imageBytes});
}

class ImageErrorState extends ImageState {
  final String message;

  ImageErrorState(this.message);
}


// part of 'image_cubit.dart';

// @immutable
// class ImageState {}

//  class ImageInitialState extends ImageState {}

// class ImageLoadedState extends ImageState {
//   // final String imagePath;
//   final Uint8List imagePath;

//   ImageLoadedState(this.imagePath);

// }

// class ImageErrorState extends ImageState {
//   final String errorMessage;

//   ImageErrorState(this.errorMessage);
// }


