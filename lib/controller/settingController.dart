import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as prefix;

import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class SettingController extends GetxController {
  late userModel usertemp;
  var picker = ImagePicker();
  bool usersisupdated = false;
  bool islogout = false;
  File? profileImage;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController diocontroller = TextEditingController();
  final MultiSelectController addresscontroller = MultiSelectController();
  final MultiSelectController statecontroller = MultiSelectController();
  @override
  void onInit() async {
    usertemp = currentuser!.copyWith();

    super.onInit();
  }

  Future<void> uploadprofileImagemassage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      update();
    } else {
      Fluttertoast.showToast(msg: 'No image selected. pls select image');
    }
  }

  void changedarkmode() {}

  void updateprofile() async {
    log("update profile");
    usersisupdated = true;
    update();
    int darkmodetemp = darkmode ? 1 : 0;
    print(phonecontroller.text);
    Map formData = ({
      if (phonecontroller.text.length > 4) 'phone': phonecontroller.text,
      if (namecontroller.text.length > 4) 'name': namecontroller.text,
      'Darkmode': darkmodetemp,
      if (statecontroller.selectedOptions[0] != null ||
          statecontroller.selectedOptions[0].label != 'none')
        'state': statecontroller.selectedOptions[0].label,
      if (addresscontroller.selectedOptions != null ||
          addresscontroller.selectedOptions[0].label != 'none')
        'address_id': addresscontroller.selectedOptions[0].value,
    });
    print(formData.toString());
    var result = await DioHelper2.postData(
        url: "updateuser", token: token, data: formData);
    print(result.data.toString());
    usersisupdated = false;
    update();
  }

  void logout() {}

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
