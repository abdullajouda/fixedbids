import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'constants.dart';

class Helper {
  Future<File> pickMainImage({@required ImageSource source}) async {
    final XFile xImage = await Data.picker.pickImage(source: source);
    if (xImage == null) {
      return null;
    }
    return File(xImage.path);
  }

  Future<File> displayPickImageDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              TextButton(
                  child: Text('Pick Image'.tr()),
                  onPressed: () async {
                    File file =
                        await pickMainImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(file);
                  }),
              TextButton(
                  child: Text('Take Picture'.tr()),
                  onPressed: () async {
                    File file = await pickMainImage(source: ImageSource.camera);
                    Navigator.of(context).pop(file);
                  }),
            ],
          );
        });
  }
}
