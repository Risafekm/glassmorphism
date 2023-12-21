// ignore_for_file: avoid_print

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource sourse) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: sourse);
  if (image != null) {
    return await image.readAsBytes();
  } else {
    print('no image picked');
  }
}
