import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram_v1/utils/info_display.dart';

Future<File?> pickImage(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    showSnackBar(context, "No Image Selected");
    throw Exception("No Image Selected");
  }
  return File(image.path);
}
