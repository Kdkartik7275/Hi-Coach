import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

import 'package:image_picker/image_picker.dart';

void httpErrorHandling({
  required VoidCallback onSuccess,
  required http.Response res,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Get.snackbar('Error', jsonDecode(res.body)['message']);

      break;
    case 500:
      Get.snackbar('Error', jsonDecode(res.body)['error']);
      break;
    default:
      Get.snackbar('Error', res.body);
  }
}

Future<File?> pickImage({bool camera = false}) async {
  try {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color(0xFF21899C),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return File(croppedFile!.path);
  } catch (e) {}
  return null;
}

Future<Position?> getCurrentLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final positon = await Geolocator.getCurrentPosition();

    return positon;
  } catch (e) {
    Get.snackbar('Location Error', e.toString(),
        backgroundColor: Colors.white, duration: Duration(seconds: 5));
  }
  return null;
}

class FileUtils {
  static String getFileExtension(File file) {
    List fileNameSplit = file.path.split(".");
    String extension = fileNameSplit.last;
    return extension;
  }

  static String getFileSize(File file) {
    return (file.lengthSync() / (1024 * 1024)).toStringAsFixed(1);
  }
}
