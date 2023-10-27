import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:usedbookshop/controller/settingController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/shared/variable.dart';

class Settingapp extends StatelessWidget {
  Settingapp({super.key});
  final SettingController settingcontroller = Get.put(SettingController());
/*statelist
                      .map((e) => ValueItem(label: e, value: e))
                      .toList(),*/
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const Maindrawer(),
      body: GetBuilder<SettingController>(
        builder: (_) => settingcontroller.usertemp == null
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 420,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: GetBuilder<SettingController>(
                                builder: (_) => Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: settingcontroller
                                                      .profileImage !=
                                                  null
                                              ? FileImage(settingcontroller
                                                      .profileImage!)
                                                  as ImageProvider
                                              : settingcontroller
                                                          .usertemp!.imageurl !=
                                                      null
                                                  ? NetworkImage(
                                                      settingcontroller
                                                          .usertemp!.imageurl!)
                                                  : NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU"),
                                          fit: BoxFit.cover)),
                                ),
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 30.0, left: 17.0),
                                child: Icon(Icons.arrow_back_ios, size: 30.0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 40),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                /*   showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                  ),
                                  builder: (BuildContext bc) {
                                    return Imagepackerform(
                                      settingcontroller: settingcontroller,
                                    );
                                  });
                           */
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          // <-- SEE HERE
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10.0),
                                          ),
                                        ),
                                        builder: (BuildContext bc) {
                                          return Imagepackerform(
                                            settingcontroller:
                                                settingcontroller,
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: '#03C988'.toColor(),
                                      child: Icon(
                                        Icons.camera_enhance,
                                        size: 25,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 8.0,
                      child: Container(
                        color: Colors.grey[100],
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Account information',
                                    style: TextStyle(color: Colors.blue)),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('change name',
                                        style: TextStyle(color: Colors.grey)),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    defaultFormField(
                                      hint: settingcontroller.usertemp!.name,
                                      controller:
                                          settingcontroller.namecontroller,
                                      type: TextInputType.name,
                                      validate: (String? value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('change phone',
                                        style: TextStyle(color: Colors.grey)),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    defaultFormField(
                                      hint: settingcontroller.usertemp!.phone,
                                      controller:
                                          settingcontroller.phonecontroller,
                                      type: TextInputType.name,
                                      validate: (String? value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('addresse',
                                        style: TextStyle(color: Colors.grey)),
                                    SizedBox(
                                      width: width - 20,
                                      child: MultiSelectDropDown.network(
                                        //   selectedOptionBackgroundColor: Colors.greenAccent,
                                        selectionType: SelectionType.single,
                                        controller:
                                            settingcontroller.addresscontroller,
                                        onOptionSelected: (options) {},
                                        networkConfig: NetworkConfig(
                                          url: '${mainUrl}addresse',
                                          method: RequestMethod.get,
                                          headers: {
                                            'Content-Type': 'application/json',
                                            'Authorization': token ?? '',
                                          },
                                        ),
                                        chipConfig: const ChipConfig(
                                            wrapType: WrapType.wrap),
                                        responseParser: (response) {
                                          var result = response["data"];

                                          final list = (result as List<dynamic>)
                                              .map((e) {
                                            final item =
                                                e as Map<String, dynamic>;
                                            return ValueItem(
                                              label:
                                                  'id = ${item["id"]} latitude = ${item['lat']} longitude = ${item['long']}',
                                              value: item['id'].toString(),
                                            );
                                          }).toList();

                                          return Future.value(list);
                                        },
                                        responseErrorBuilder: ((context, body) {
                                          return const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child:
                                                Text('Error fetching the data'),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                //add addresse
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: TextButton(
                                          onPressed: () {},
                                          child:
                                              const Text('add new addresse')),
                                    ),
                                  ],
                                ),
                                //add state
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                        child: Text('status',
                                            style:
                                                TextStyle(color: Colors.grey))),
                                    SizedBox(
                                      width: width - 20,
                                      child: MultiSelectDropDown(
                                        searchEnabled: true,
                                        hint: 'المحافظة',
                                        controller:
                                            settingcontroller.statecontroller,
                                        onOptionSelected: (List<ValueItem>
                                            selectedOptions) {},
                                        options: statelist
                                            .map((e) =>
                                                ValueItem(label: e, value: e))
                                            .toList(),
                                        selectionType: SelectionType.single,
                                        chipConfig: const ChipConfig(
                                            wrapType: WrapType.wrap),
                                        dropdownHeight: 400,
                                        optionTextStyle:
                                            const TextStyle(fontSize: 16),
                                        selectedOptionIcon:
                                            const Icon(Icons.check_circle),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Dark mode'),
                                    GetBuilder<SettingController>(
                                      builder: (_) => Checkbox(
                                        value: darkmode,
                                        onChanged: (value) {
                                          darkmode = !darkmode;

                                          Get.changeThemeMode(
                                            darkmode
                                                ? ThemeMode.light
                                                : ThemeMode.dark,
                                          );
                                          settingcontroller.update();
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      child: Container(
                        color: Colors.grey[100],
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Account information',
                                    style: TextStyle(color: Colors.blue)),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.notification_add),
                                      Text('notification setting'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.lock),
                                      Text('privacy and security'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    print('test');
                                  },
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.chat_bubble),
                                      Text('chat setting'),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 15.0,
                        left: 15.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: GetBuilder<SettingController>(
                        builder: (_) => DefaultButton(
                          radius: 10,
                          function: () {
                            settingcontroller.updateprofile();
                          },
                          noWidget: !settingcontroller.usersisupdated,
                          text: 'update data',
                          childwidget: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 1, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                          left: 15.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: GetBuilder<SettingController>(
                          builder: (_) => DefaultButton(
                              radius: 10,
                              background: Colors.red,
                              function: () {
                                //  Cubitsetting.get(context).logout();
                                logout();
                              },
                              text: 'logout'),
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}

class Imagepackerform extends StatelessWidget {
  const Imagepackerform({super.key, required this.settingcontroller});
  final SettingController settingcontroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('camera'),
              onTap: () {
                settingcontroller.uploadprofileImagemassage(ImageSource.camera);
                Navigator.pop(context);
              }),
          ListTile(
              leading: const Icon(Icons.image),
              title: const Text('gallery'),
              onTap: () {
                settingcontroller
                    .uploadprofileImagemassage(ImageSource.gallery);
                Navigator.pop(context);
              }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
