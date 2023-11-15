import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as prefix;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

class Sellcontroller extends GetxController {
  final TextEditingController booknamecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController authorcontroller = TextEditingController();
  final TextEditingController statuscontroller = TextEditingController();
  final TextEditingController discriptioncontroller = TextEditingController();
  final MultiSelectController addresscontroller = MultiSelectController();
  final MultiSelectController categorycontroller = MultiSelectController();
  final MultiSelectController statecontroller = MultiSelectController();
  List<prefix.MultipartFile> selectedImages = [];
  List<String> selectedcategoryList = [];
  List<XFile> xfilePick = [];
  var picker = ImagePicker();
  File? temp;

  prefix.MultipartFile? temp2;
  final TextEditingController longcontroller = TextEditingController();
  final TextEditingController latcontroller = TextEditingController();

  //for widget from get location
  void makeupdate() {
    update();
  }

  Future<void> setimage() async {
    selectedImages = [];
    final pickedFile = await picker.pickMultiImage(
        //source: source,
        );
    xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        temp = File(xfilePick[i].path);

        String fileName = temp!.path.toString().split('/').last;
     //   String extend = temp!.path.toString().split('.').last;
        // Fluttertoast.showToast(msg: extend.toString());
        print(fileName.toString());

        var temp2 = await prefix.MultipartFile.fromFile(
          temp!.path,
          filename: fileName,
        );
        // temp = base64Encode(await temp.readAsBytes());
        selectedImages.add(temp2);
      }
      // Fluttertoast.showToast(msg: selectedImages.length.toString());
    } else {
      Fluttertoast.showToast(msg: 'Nothing is selected');
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      /*  ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));*/
    }
    update();
  }

  void addusedBook() async {
    selectedcategoryList = [];
    if (selectedImages.isEmpty) {
      Fluttertoast.showToast(msg: "Please select an image");
    } else if (categorycontroller.selectedOptions.length > 5 ||
        categorycontroller.selectedOptions.length < 1) {
      //      print("Selecte Category ${selectescategoryList}");
      Fluttertoast.showToast(
          msg: "Please selected categories mustbe between 1 and 5");
    } else {
      for (var category in categorycontroller.selectedOptions) {
        selectedcategoryList.add(category.value!);
      }

      prefix.FormData formData = prefix.FormData.fromMap({
        "name": booknamecontroller.text,
        "author": authorcontroller.text,
        "status": statecontroller.selectedOptions[0].label,
        "price": pricecontroller.text,
        "addresse_id": addresscontroller.selectedOptions[0].value,
        "discription": discriptioncontroller.text,
        "category[]": selectedcategoryList,
        "image[]": selectedImages,
      });
      print(formData.fields.toString());
      var result = await DioHelper2.postData(
          url: "book", t: false, token: token, data: formData);
      //   print(result.toString());

      if (result.data["status"] == "200" || result.data["status"] == 200) {
        Fluttertoast.showToast(msg: "upload done");
      } else if (result.data["status"] != null &&
          result.data["status"] != 200) {
        Fluttertoast.showToast(
            msg: result.data["status"]['message'].toString());
        print("error happenrd");
      } else if (result.data["error"] != null) {
        Fluttertoast.showToast(msg: result.data["error"].toString());
      } else {
        Fluttertoast.showToast(msg: "error happenrd");
      }
    }

    //api call to get categories
  }

  void addaddresse(var result) {
    var item = result["data"];
    addresscontroller.addOneOptions([
      ValueItem(
          label: ' latitude = ${item['lat']} longitude = ${item['long']}',
          value: item['id'].toString())
    ]);
    update();
  }
  /* void getcategorie() async {
    var result =
        await DioHelper2.getData(url: 'category', token: token, query: {});

    if (result.data["status"] == "200") {
      for (var category in result.data["categorys"]) {
        categoryList.add(CategoryModul.fromjson(category));
      }
    } else if (result.data["status"]['message'] != null) {
      Fluttertoast.showToast(msg: result.data["status"]['message']);
    } else {
      Fluttertoast.showToast(msg: "error happenrd");
    }
  }*/
/*
  void getaddresse() async {
    var result =
        await DioHelper2.getData(url: 'addresse', token: token, query: {});

    if (result.data["status"] == "200") {
      for (var address in result.data["data"]) {
        addresseList.add(Addresses.fromjson(address));
      }
      dropdownaddresseList = addresseList
          .map((Addresses item) => DropdownMenuItem<String>(
              child: Text(item.lat.toString()), value: item.id.toString()))
          .toList();
    } else if (result.data["status"]['message'] != null) {
      Fluttertoast.showToast(msg: result.data["status"]['message']);
    } else {
      Fluttertoast.showToast(msg: "error happenrd");
    }
  }*/
}
