import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:usedbookshop/controller/otherprofilecontroller.dart';

import 'package:usedbookshop/models/prevbookmodel.dart';

import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/view/bookdetailsView.dart';

class Otherprofileview extends StatelessWidget {
  Otherprofileview({super.key});
  final OtherprofileController profilecontroller = Get.put(
      OtherprofileController(userId: Get.arguments[0]["user_id"].toString()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const Maindrawer(),
        bottomNavigationBar: GetBuilder<OtherprofileController>(
            builder: (_) => profilecontroller.sellerUser != null
                ? MainBottomBar(user: profilecontroller.sellerUser!.user)
                : Container()),
        backgroundColor: Color.fromARGB(246, 255, 255, 255),
        body: GetBuilder<OtherprofileController>(
          builder: (_) => profilecontroller.sellerUser == null
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 420,
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: GetBuilder<OtherprofileController>(
                                    builder: (_) => Container(
                                      width: double.infinity,
                                      height: 400,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: profilecontroller
                                                          .sellerUser!
                                                          .user
                                                          .imageurl !=
                                                      null
                                                  ? NetworkImage(
                                                      profilecontroller
                                                          .sellerUser!
                                                          .user
                                                          .imageurl!)
                                                  : const NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU"),
                                              fit: BoxFit.cover)),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 17.0),
                                  child: InkWell(
                                      onTap: () {
                                        print(Get.arguments);
                                        if (Get.arguments[1]["book_id"] !=
                                            null) {
                                          Get.off(() => OnebookView(),
                                              arguments:
                                                  Get.arguments[1]["book_id"]);
                                        } else {
                                          Get.back();
                                        }
                                      },
                                      child: const Icon(Icons.arrow_back_ios,
                                          size: 30.0)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                  height: 60,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                itemSize: 30.0,
                                glowColor: Colors.lightGreen,
                                initialRating: (profilecontroller
                                            .sellerUser!.user.myrate !=
                                        null)
                                    ? double.parse(profilecontroller
                                        .sellerUser!.user.myrate!)
                                    : 1,
                                minRating: 1,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  size: 2,
                                  Icons.star,
                                  color: Colors.amber,
                                  weight: 30,
                                ),
                                onRatingUpdate: (rating) {
                                  profilecontroller.giverate(rating.toInt());
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                profilecontroller.sellerUser!.user.numberrates
                                        .toString() +
                                    ' rates',
                                style: GoogleFonts.asar(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('name'),
                                subtitle: Text(
                                    profilecontroller.sellerUser!.user.name),
                                trailing: const Icon(Icons.person),
                              ),
                              ListTile(
                                title: Text('Address'),
                                subtitle: Text(
                                    profilecontroller.sellerUser!.user.state ??
                                        'Egypt'),
                                trailing: const Icon(Icons.place),
                                /* trailing: IconButton(
                                    icon: Icon(Icons.edit_outlined),
                                    onPressed: () async{
                                    }
                                    ),*/
                              ),
                              ListTile(
                                title: Text('email'),
                                subtitle: Text(
                                    profilecontroller.sellerUser!.user.email),
                                trailing: InkWell(
                                    child: Icon(Icons.email),
                                    onTap: () async {}),
                              ),
                              ListTile(
                                title: Text('number of books'),
                                subtitle: Text(profilecontroller
                                    .sellerUser!.booknumber
                                    .toString()),
                                trailing: Icon(Icons.book_online_rounded),
                              ),
                              ListTile(
                                title: Text('average rating'),
                                subtitle: Text(profilecontroller
                                        .sellerUser!.user.avragerate ??
                                    '0' + '  rate'),
                                trailing: Icon(Icons.book_online_rounded),
                              ),
                              ListTile(
                                title: Text('created at'),
                                subtitle: Text(profilecontroller
                                    .sellerUser!.user
                                    .getcreateat()),
                                trailing: const Icon(Icons.date_range),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      const SliverToBoxAdapter(
                          child: Divider(
                              color: Colors.black, height: 2, thickness: 1)),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ' User\'s products ',
                            style: GoogleFonts.openSans(fontSize: 20),
                          ),
                        ),
                      ),
                      //  SliverToBoxAdapter(child: ,),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          child: ListView.builder(
                              itemCount:
                                  profilecontroller.sellerUser!.books.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                PrevBook onebook =
                                    profilecontroller.sellerUser!.books[i];
                                return SizedBox(
                                  height: 800,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              '/onebook',
                                              arguments: profilecontroller
                                                  .sellerUser!.books[i].id,
                                              // preventDuplicates: false,
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: onebook.image != null
                                                        ? NetworkImage(
                                                            onebook.image!)
                                                        : NetworkImage(
                                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU"),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(onebook.name),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(onebook.price + ' LE'),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
