/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usedbookshop/controller/settingController.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/shared/variable.dart';

class Settingapp extends StatelessWidget {
  Settingapp({super.key});
  final SettingController settingcontroller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 420,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: settingcontroller.usertemp.imageurl == null
                                  ? NetworkImage(
                                      settingcontroller.usertemp.imageurl!)
                                  : FileImage(settingcontroller.profileImage)
                                      as ImageProvider,
                              fit: BoxFit.cover)),
                    )),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 17.0),
                    child: Icon(Icons.arrow_back_ios, size: 30.0),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
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
                                settingcontroller: settingcontroller,
                              );
                            });
                      },
                      child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.camera_enhance,
                            size: 25,
                          )),
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
                      InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentuser!.name),
                            const Text('tap to change name',
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentuser!.phone ?? 'enter number'),
                              const Text('tap to change phone',
                                  style: TextStyle(color: Colors.grey))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bio'),
                            // '${bio ?? (Cubitsetting.get(context).userModel!.bio ?? "Bio:")} '),
                            Text('add a few words about yourself',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
            child: DefaultButton(
                radius: 10,
                function: () {
                  settingcontroller.updateprofile();
                },
                text: 'update data'),
          ),
          Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 5.0,
                bottom: 5.0,
              ),
              child: DefaultButton(
                  radius: 10,
                  background: Colors.red,
                  function: () {
                    //  Cubitsetting.get(context).logout();
                    settingcontroller.logout();
                  },
                  text: 'logout')),
        ],
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
*/