import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitialState());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        final bytes = await pickedImage.readAsBytes(); // works on all platforms
        emit(ImageLoadedState(imageBytes: bytes));
      } else {
        emit(ImageErrorState('No image selected'));
      }
    } catch (e) {
      emit(ImageErrorState('Error picking image: $e'));
    }
  }

  void reset() {
    emit(ImageInitialState());
  }
}




// import 'dart:typed_data';

// import 'package:bloc/bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meta/meta.dart';

// part 'image_state.dart';

// class ImageCubit extends Cubit<ImageState> {
//   ImageCubit() : super(ImageInitialState());

//   final ImagePicker _imagepicker = ImagePicker();

//   Future<void> pickImage() async {
//     try {
//       final pickedImage = await _imagepicker.pickImage(
//         source: ImageSource.gallery,
//       );
//       if (pickedImage != null) {
//         emit(ImageLoadedState(pickedImage));
//       } else {
//         emit(ImageErrorState('No image selected'));
//       }
//     } catch (e) {
//       emit(ImageErrorState(e.toString()));
//     }
//   }

//   void reset() {
//     emit(ImageInitialState());
//   }
// }
