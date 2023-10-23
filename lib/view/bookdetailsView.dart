import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/bookdetailsController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:google_fonts/google_fonts.dart';

class OnebookView extends StatelessWidget {
  OnebookView({super.key});
  final Bookdetailscontroller pagecontroller =
      Get.put(Bookdetailscontroller(id: Get.arguments.toString()));
  @override
  Widget build(BuildContext context) {
    //int itemCount;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: '#03C988'.toColor(),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text('product details'),
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
                                            decoration: BoxDecoration(
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
                      SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              pagecontroller.bookalldata.book.name,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                child: IconButton(
                                  iconSize: 30,
                                  onPressed: () {},
                                  icon: (pagecontroller.bookalldata.favourite)
                                      ? Icon(
                                          Icons.favorite_border,
                                        )
                                      : Icon(
                                          Icons.favorite_rounded,
                                          color: '#03C988'.toColor(),
                                        ),
                                ))
                          ],
                        ),
                      ),
                      Center(
                        child:
                            Text(pagecontroller.bookalldata.book.discription),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        // height: 80,
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${pagecontroller.bookalldata.book.addresses.toString()}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    '${pagecontroller.bookalldata.book.getdate()}',
                                    style: GoogleFonts.openSans(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      spliter(),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(10, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  'Details',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      SizedBox(
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
                                      SizedBox(
                                        width: 82,
                                        child: Text('condition : '),
                                      ),
                                      Text(pagecontroller
                                          .bookalldata.book.status),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 90,
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
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  pagecontroller.bookalldata.seller.imageurl ??
                                      'notnow'),
                              radius: MediaQuery.of(context).size.width / 14,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                Text(pagecontroller.bookalldata.seller.name),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(pagecontroller.bookalldata.seller
                                                .avragerate ==
                                            'null'
                                        ? pagecontroller
                                            .bookalldata.seller.avragerate
                                            .toString()
                                        : '0'),
                                  ],
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(80, 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    print(100);
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
                      spliter(),
                      Center(
                        child: Text('Location',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(pagecontroller.bookalldata.book.addresses
                            .toString()),
                      ),
                      //هنا مفروض يكون زرار يعرض المكان على جوجل
                      Text('Share location'),
                      SizedBox(height: 140),
                    ],
                  ),
                )
              : CircularProgressIndicator(),
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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: '#03C988'.toColor().withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(5, 8), // changes position of shadow
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
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (user.phone == null) {
                      Fluttertoast.showToast(
                          msg: 'he doesn\'t have a mobile number');
                    }
                  },
                  child: Icon(
                    Icons.sms_outlined,
                    size: 26,
                  )),
              SizedBox(
                width: 5,
              ),
              Text('SMS')
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.forum_outlined,
                    size: 26,
                  )),
              SizedBox(
                width: 5,
              ),
              Text('chat')
            ],
          ),
          InkWell(
            onTap: () {
              print('4');
              if (user.phone == null) {
                Fluttertoast.showToast(msg: 'he doesn\'t have a mobile number');
              }
            },
            child: Row(
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
