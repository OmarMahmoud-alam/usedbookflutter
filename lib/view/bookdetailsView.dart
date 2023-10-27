import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:usedbookshop/controller/bookdetailsController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/launcher/launcher.dart';
import 'package:usedbookshop/view/chat/chat.dart';
import 'package:usedbookshop/view/otherprofileview.dart';

import '../utils/geolocation/geolocation.dart';

class OnebookView extends StatefulWidget {
  OnebookView({super.key});

  @override
  State<OnebookView> createState() => _OnebookViewState();
}

class _OnebookViewState extends State<OnebookView> {
  final Bookdetailscontroller pagecontroller =
      Get.put(Bookdetailscontroller(id: Get.arguments.toString()));
  //final Bookdetailscontroller pagecontroller = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<Bookdetailscontroller>(force: true);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //int itemCount;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: '#03C988'.toColor(),
          leading: IconButton(
            onPressed: () {
              Get.delete<Bookdetailscontroller>(force: true);

              Get.back(result: true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('product details'),
          //   backgroundColor: ,
        ),
        bottomNavigationBar: GetBuilder<Bookdetailscontroller>(
            builder: (_) => pagecontroller.banner.length != 0
                ? MainBottomBar(user: pagecontroller.bookalldata.seller)
                : Container()),
        body: GetBuilder<Bookdetailscontroller>(
          builder: (_) => (pagecontroller.banner.length != 0)
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250.0,
                        child: (pagecontroller.banner.length != 0)
                            ? Container(
                                child: CarouselSlider(
                                  items: pagecontroller.banner
                                      .map((item) => Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.black))),
                                            /* color: '#03C988'
                                                .toColor()
                                                .withOpacity(0.4),*/
                                            child: Center(
                                              child: Image(
                                                // width: 700,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(item),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  options: CarouselOptions(
                                    height: 250.0,
                                    viewportFraction: 1.0,
                                    autoPlay: true,
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pagecontroller.bookalldata.book.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.grey.withOpacity(0),
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon: (pagecontroller.bookalldata.favourite)
                                    ? const Icon(
                                        Icons.favorite_border,
                                      )
                                    : Icon(
                                        Icons.favorite_rounded,
                                        color: '#03C988'.toColor(),
                                      ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            pagecontroller.bookalldata.book.discription,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            '${pagecontroller.bookalldata.book.getdate()}',
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        // height: 80,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /* Text(
                                    '${pagecontroller.bookalldata.book.addresses.toString()}',
                                    style: const TextStyle(fontSize: 20),
                                  ),*/
                                  Expanded(
                                    child: Text(
                                      pagecontroller.addresseString != null &&
                                              pagecontroller
                                                      .addresseString![0] ==
                                                  'sucess'
                                          ? pagecontroller.addresseString![1]
                                              .toString()
                                          : pagecontroller
                                              .bookalldata.book.addresses
                                              .toString(),
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const spliter(),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    10, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                const Text(
                                  'Details',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                if (pagecontroller.bookalldata.book.author !=
                                    null)
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 82,
                                          child: Text('author : '),
                                        ),
                                        Text(pagecontroller
                                            .bookalldata.book.author!),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 82,
                                        child: Text('price : '),
                                      ),
                                      Text(pagecontroller
                                              .bookalldata.book.price +
                                          'L E'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 82,
                                        child: Text('condition : '),
                                      ),
                                      Text(pagecontroller
                                          .bookalldata.book.status),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 82,
                                        child: Text('created at:'),
                                      ),
                                      Text(pagecontroller.bookalldata.book
                                          .getdate()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.only(top: 11),
                                          child: Text('categories : '),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (BuildContext, i) {
                                                return categorycard(
                                                    categoryname: pagecontroller
                                                        .bookalldata
                                                        .book
                                                        .categories[i]
                                                        .name);
                                              },
                                              itemCount: pagecontroller
                                                  .categorylength),
                                        ),
                                      ]),
                                ),
                              ]))),
                      SizedBox(
                        height: 90,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(pagecontroller
                                      .bookalldata.seller.imageurl ??
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU'),
                              radius: MediaQuery.of(context).size.width / 14,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(pagecontroller.bookalldata.seller.name),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(pagecontroller.bookalldata.seller
                                                .avragerate !=
                                            ''
                                        ? pagecontroller
                                            .bookalldata.seller.avragerate
                                            .toString()
                                        : '0'),
                                  ],
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(80, 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    Get.delete<Bookdetailscontroller>(
                                        force: true);
                                    Get.off(() => Otherprofileview(),
                                        arguments: [
                                          {
                                            "user_id": pagecontroller
                                                .bookalldata.seller.id
                                          },
                                          {
                                            "book_id": pagecontroller
                                                .bookalldata.book.id
                                          },
                                        ]);
                                  },
                                  child: const Text('see profile ->',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const spliter(),
                      const Center(
                        child: Text('Location',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 70,
                              child: Text(
                                pagecontroller.addresseString != null &&
                                        pagecontroller.addresseString![0] ==
                                            'sucess'
                                    ? pagecontroller.addresseString![1]
                                        .toString()
                                    : pagecontroller.bookalldata.book.addresses
                                        .toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                MapsSheet.show(
                                  context: context,
                                  onMapTap: (map) {
                                    map.showMarker(
                                      coords: Coords(
                                          double.parse(pagecontroller
                                              .bookalldata.book.addresses.lat),
                                          double.parse(pagecontroller
                                              .bookalldata
                                              .book
                                              .addresses
                                              .long)),
                                      title: pagecontroller
                                          .bookalldata.seller.name,
                                      // zoom: zoom,
                                    );
                                  },
                                );
                                /* MapsSheet2.show(
                                  onMapTap: (map) {
                                    map.showMarker(
                                      coords: Coords(
                                          double.parse(pagecontroller
                                              .bookalldata.book.addresses.lat),
                                          double.parse(pagecontroller
                                              .bookalldata
                                              .book
                                              .addresses
                                              .long)),
                                      title: pagecontroller
                                          .bookalldata.seller.name,
                                      // zoom: zoom,
                                    );
                                  },
                                );*/
                              },
                              icon: const Icon(Icons.location_on))
                        ],
                      ),
                      //هنا مفروض يكون زرار يعرض المكان على جوجل
                      // const Text('Share location'),
                      const SizedBox(height: 140),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ));
  }
}

class categorycard extends StatelessWidget {
  const categorycard({
    super.key,
    required this.categoryname,
  });

  final String categoryname;

  @override
  Widget build(BuildContext context) {
    return Container(
        //sssheight: 1,
        //width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: '#03C988'.toColor().withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(5, 8), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(right: 10, bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Center(child: Text(categoryname)),
        ));
  }
}

class spliter extends StatelessWidget {
  const spliter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }
}
/*
class MainBottomBar extends StatelessWidget {
  final userModel user;

  const MainBottomBar({
    Key? key,
    required this.user,
    // required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () async {
              print('sms');

              if (user.phone == null) {
                Fluttertoast.showToast(msg: 'he doesn\'t have a mobile number');
              } else {
                await Launcher.makesms(user.phone!);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.sms_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('SMS')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('chat');
              if (user.id == currentuser!.id) {
                Get.snackbar('chat', 'you can\'t chat with you self ',
                    backgroundColor: Colors.red);
              } else {
                Get.to(() => ChatScreen(), arguments: user.id);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.forum_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('chat')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('4');
              if (user.phone == null) {
                Fluttertoast.showToast(msg: 'he doesn\'t have a mobile number');
              } else {
                Launcher.makePhoneCall(user.phone!);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('call')
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
*/