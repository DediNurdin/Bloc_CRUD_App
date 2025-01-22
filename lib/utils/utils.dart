import 'dart:convert';
import 'dart:io';

import '../bloc/cubit/theme_cubit.dart';
import '../presentation/screens/my_account/theme_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class MyAccountItemWidget extends StatelessWidget {
  const MyAccountItemWidget(
      {super.key,
      required this.icon,
      required this.title,
      this.trailingText,
      this.onTap});

  final IconData icon;
  final String title;
  final String? trailingText;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeText =
            state.themeMode == ThemeMode.dark ? "Dark Mode" : "Light Mode";
        return GestureDetector(
          onTap: () {
            switch (title) {
              case 'Theme':
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ThemePage()),
                );
                break;
            }
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  icon,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              trailingText != null
                  ? Text(
                      themeText,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    )
                  : Text(''),
              const SizedBox(width: 15),
            ],
          ),
        );
      },
    );
  }
}

class MainMenuItemWidget extends StatelessWidget {
  const MainMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}

class Utils {
  static String baseUrlFakeApi = 'https://fakestoreapi.com';

  static Future showToast(String msg, bool isError) {
    return Fluttertoast.showToast(
        backgroundColor: isError ? CupertinoColors.destructiveRed : null,
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 13);
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Widget customColumn(BuildContext context, Widget child) {
    return Column(
      children: [
        Container(
          color: Utils.isDarkMode(context)
              ? CupertinoColors.black
              : CupertinoColors.lightBackgroundGray,
          height: 10,
        ),
        Container(
          color: Utils.isDarkMode(context)
              ? CupertinoColors.darkBackgroundGray
              : CupertinoColors.systemBackground,
          child: child,
        )
      ],
    );
  }

  static Widget buttonWigget(
    void Function() onPressed,
    Widget child,
    bool isOutline,
  ) {
    return isOutline
        ? OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.green),
              side: WidgetStatePropertyAll(BorderSide(color: Colors.green)),
            ),
            child: child,
          )
        : ElevatedButton(onPressed: onPressed, child: child);
  }

  static Widget styleBuildLeadingAppBarSearch(void Function() onPressed) {
    return IconButton(
      icon: const Icon(
        CupertinoIcons.arrow_left,
      ),
      onPressed: onPressed,
    );
  }

  static Widget imageNetwork(BuildContext context, String srcImg, double size) {
    return Image.network(
      srcImg,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
            height: size,
            child: Assets.icons.noImage.image(
                color:
                    Utils.isDarkMode(context) ? Colors.white : Colors.black));
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
            height: size,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ));
      },
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

  static const String keyToken = 'token_key';

  static Future<void> saveToken(String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, userData);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataToken = prefs.getString(keyToken);

    return userDataToken;
  }

  static Future<void> removeTokenData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
  }

  static const String keyUser = 'user_key';

  static Future<void> saveUser(int userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyUser, userData);
  }

  static Future<int?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userDataUser = prefs.getInt(keyUser);

    return userDataUser;
  }

  static Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUser);
  }

  static Future<void> removeAllKeyPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    for (String key in preferences.getKeys()) {
      if (key != "user_key" && key != "token_key") {
        preferences.remove(key);
      }
    }
  }
}
