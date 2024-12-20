import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  static List<Widget> styleBuildActionAppBarSearch(
      void Function() onPressed, bool visible) {
    return [
      Visibility(
        visible: visible,
        child: InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text('Batal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          ),
        ),
      )
    ];
  }

  static Widget styleBuildLeadingAppBarSearch(void Function() onPressed) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_rounded,
      ),
      onPressed: onPressed,
    );
  }

  static Future<void> selectDate(
      BuildContext context,
      DateTime initDate,
      String dateFormat,
      Function(DateTime, String) onDateSelect,
      DateTime lastDate) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initDate) {
      onDateSelect(pickedDate, DateFormat(dateFormat).format(pickedDate));
    }
  }

  static Future<void> selectImage(
      Function(String, File) onImagePicked, bool isCamera) async {
    try {
      final image = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 85);

      if (image == null) return;

      final imageTemp = File(image.path);

      Uint8List imageBytes = await imageTemp.readAsBytes();
      if (kDebugMode) {
        print(imageBytes);
      }

      String base64StringImage = base64.encode(imageBytes);
      if (kDebugMode) {
        print(base64StringImage);
      }

      onImagePicked(base64StringImage, imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
}
