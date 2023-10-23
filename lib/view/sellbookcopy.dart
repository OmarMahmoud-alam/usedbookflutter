import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:usedbookshop/controller/sellcontroller.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/shared/variable.dart';

class SellBookMain extends StatelessWidget {
  SellBookMain({super.key});
  final Sellcontroller sellcontroller = Get.put(Sellcontroller());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      

      appBar: AppBar(
        backgroundColor: '#03C988'.toColor(),
        title: const Text('بيع كتب'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          //add image
          InkWell(
            onTap: () {
              sellcontroller.setimage();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .4,
              child: const Center(child: Icon(Icons.add_a_photo)),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black38)),
            ),
          ),
          //add book(name ,price, author ,discription)
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 7,
              shadowColor: Colors.greenAccent.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(10),

                // height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: '#03C988'.toColor(),
                        style: BorderStyle.solid)),
                child: Column(
                  children: [
                    //book name
                    SizedBox(
                      width: double.infinity,
                      height: boxsizedlengthofsellpage,
                      child: Row(
                        children: [
                          const SizedBox(width: 80, child: Text('Book name')),
                          Expanded(
                            child: TextFormField(
                                textDirection: TextDirection.ltr,
                                controller: sellcontroller.booknamecontroller,
                                keyboardType: TextInputType.text,
                                //obscureText: sellcontroller.ispassword,
                                validator: (value) {
                                  if (value == null || (value.trim()) == "") {
                                    return 'pls enter book name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              195, 105, 240, 175)),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    hintText: ' book name',
                                    hintTextDirection: TextDirection.ltr)),
                          ),
                        ],
                      ),
                    ),
                    //book price
                    SizedBox(
                      width: double.infinity,
                      height: boxsizedlengthofsellpage,
                      child: Row(
                        children: [
                          const SizedBox(width: 80, child: Text('Book price')),
                          Expanded(
                            child: TextFormField(
                                textDirection: TextDirection.ltr,
                                controller: sellcontroller.pricecontroller,
                                keyboardType: TextInputType.number,
                                //obscureText: sellcontroller.ispassword,
                                validator: (value) {
                                  if (value == null || (value.trim()) == "") {
                                    return 'pls enter book price';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              195, 105, 240, 175)),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    hintText: ' book price',
                                    hintTextDirection: TextDirection.ltr)),
                          ),
                        ],
                      ),
                    ),
                    //book author
                    SizedBox(
                      width: double.infinity,
                      height: boxsizedlengthofsellpage,
                      child: Row(
                        children: [
                          const SizedBox(width: 80, child: Text('Book author')),

                          Expanded(
                            child: TextFormField(
                                textDirection: TextDirection.ltr,
                                controller: sellcontroller.authorcontroller,
                                keyboardType: TextInputType.text,
                                //obscureText: sellcontroller.ispassword,
                                validator: (value) {
                                  if (value == null || (value.trim()) == "") {
                                    return 'pls enter book author';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              195, 105, 240, 175)),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    hintText: ' book author',
                                    hintTextDirection: TextDirection.ltr)),
                          ),
                        ],
                      ),
                    ),
                    //book discription
                    SizedBox(
                      width: double.infinity,
                      //height: 80,
                      child: Row(
                        children: [
                          const SizedBox(
                              width: 80,
                              child: Text('Book description',
                                  textAlign: TextAlign.center)),
                          Expanded(
                            child: TextFormField(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                controller:
                                    sellcontroller.discriptioncontroller,
                                keyboardType: TextInputType.text,
                                minLines: 3,
                                maxLines: 5,
                                //obscureText: sellcontroller.ispassword,
                                validator: (value) {
                                  if (value == null || (value.trim()) == "") {
                                    return 'pls enter book discription';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              195, 105, 240, 175)),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    hintText: ' book discription',
                                    hintTextDirection: TextDirection.ltr)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //categories
          Row(
            children: [
              const SizedBox(
                  width: 100,
                  child: Text(
                    'book category',
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: width - 110,
                child: MultiSelectDropDown.network(
                  dropdownHeight: 400,
                  hint: 'تصنيف الكتاب ',
                  controller: sellcontroller.categorycontroller,
                  maxItems: 5,
                  searchEnabled: true,
                  onOptionSelected: (options) {},
                  //ptionsBackgroundColor: Colors.greenAccent,
                  networkConfig: NetworkConfig(
                    url: '${mainUrl}category',
                    method: RequestMethod.get,
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': token ?? '',
                    },
                  ),
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  responseParser: (response) {
                    var result = response["categorys"];
                    final list = (result as List<dynamic>).map((e) {
                      final item = e as Map<String, dynamic>;
                      return ValueItem(
                        label: item['name'],
                        value: item['id'].toString(),
                      );
                    }).toList();

                    return Future.value(list);
                  },
                  responseErrorBuilder: ((context, body) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Error fetching the data'),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          //addresse dropdown2
          
          Row(
            children: [
              const SizedBox(
                  width: 100,
                  child: Text(
                    'addresse',
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: width - 110,
                child: MultiSelectDropDown.network(
                  //   selectedOptionBackgroundColor: Colors.greenAccent,
                  selectionType: SelectionType.single,
                  controller: sellcontroller.addresscontroller,
                  onOptionSelected: (options) {},
                  networkConfig: NetworkConfig(
                    url: '${mainUrl}addresse',
                    method: RequestMethod.get,
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': token ?? '',
                    },
                  ),
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  responseParser: (response) {
                    var result = response["data"];

                    final list = (result as List<dynamic>).map((e) {
                      final item = e as Map<String, dynamic>;
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
                      child: Text('Error fetching the data'),
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
                width: 100,
              ),
              SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () {}, child: const Text('add new addresse')),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //status حالة المنتج
          Row(
            children: [
              const SizedBox(
                  width: 100,
                  child: Text(
                    'book status',
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: width - 110,
                child: MultiSelectDropDown(
                  hint: 'حالة المنتج',
                  controller: sellcontroller.statecontroller,
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: const <ValueItem>[
                    ValueItem(label: 'جديد ', value: '1'),
                    ValueItem(label: 'مستعمل بحاله جيد', value: '2'),
                    ValueItem(label: 'مستعمل بحاله متوسط', value: '3'),
                    ValueItem(label: 'فاقد بعض الورق', value: '4'),
                    ValueItem(label: 'بحالة سئ', value: '5'),
                  ],
                  selectionType: SelectionType.single,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 240,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 40,
          ),

          MainButton(
            function: () {
              sellcontroller.addusedBook();
            },
            text: 'بيع كتاب ',
            background: '#03C988'.toColor(),
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}

class imagepackerform extends StatelessWidget {
  const imagepackerform({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('camera'),
              onTap:
                  () {} //=> blocprovid.SendImagemassage(ImageSource.camera, user),
              ),
          ListTile(
              leading: const Icon(Icons.image),
              title: const Text('gallery'),
              onTap:
                  () {} // => blocprovid.SendImagemassage(ImageSource.gallery, user),
              ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
