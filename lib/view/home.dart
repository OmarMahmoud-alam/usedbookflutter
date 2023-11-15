import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:usedbookshop/controller/Homecontroller.dart';
import 'package:usedbookshop/models/bookmodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/shared/variable.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final leading = const Icon(
    Icons.search,
    color: Colors.black,
  );
  final searchcontroller = SearchController();
  final Homecontroller homecontroller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: const Maindrawer(),
        backgroundColor: Color.fromARGB(246, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  toolbarHeight: 75,
                  shadowColor:
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                  backgroundColor:
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                  title: searchwidget(
                      searchcontroller: searchcontroller, leading: leading),
                ),
                /* SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white.withOpacity(0)),*/
                const Gap(
                  height: 5,
                ),
                PagedSliverList<int, Book>(
                  pagingController: homecontroller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Book>(
                      itemBuilder: (context, item, index) {
                    return BookWidget(
                      width: width,
                      height: height,
                      book: item,
                    );
                  }),
                )
                /*  SliverList(
                  
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return BookWidget(width: width, height: height);
                  }, childCount: 10),
                )*/
              ],
            ),
          ),
        ));
  }
}

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.width,
    required this.height,
    required this.book,
  });

  final double width;
  final Book book;
  final double height;

  @override
  Widget build(BuildContext context) {
    var categorylength = book.categories.length;
    return InkWell(
      onTap: () {
        Get.toNamed(
          '/onebook',
          arguments: book.id,
          //   id: 1
          // preventDuplicates: false,
        );
      },
      child: Container(
        width: double.infinity,
        height: 180,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            //border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                /*BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),*/
                image: DecorationImage(
                  image: NetworkImage(
                    book.image ??
                        'https://thumbs.dreamstime.com/z/set-reading-glasses-books-over-window-57332911.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            /* Placeholder(
          fallbackWidth: MediaQuery.of(context).size.width / 20,
          fallbackHeight: MediaQuery.of(context).size.height / 6,
        ),*/

            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 3, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        // height: 20,
                        child: Text(
                          book.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              //  height: 0.80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: width - 343,
                      ),
                  
                      PopupMenuButton<int>(
                        itemBuilder: (context) => [
                          // PopupMenuItem 1

                          PopupMenuItem(
                            value: 1,
                            // row with 2 children
                            child: Row(
                              children: [
                                Icon(Icons.star),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("add to favourite")
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                          PopupMenuItem(
                            value: 2,
                            // row with 2 children
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("delete to favourite")
                              ],
                            ),
                          ),
                        ],
                        offset: Offset(0, 0),
                        color: Colors.grey.withOpacity(0.9),
                        elevation: 2,
                        // on selected we show the dialog box
                        onSelected: (value) async {
                          if (value == 1) {
                            final response = await DioHelper2.postData(
                              token: token,
                              data: {'book_id': book.id},
                              url: '/favourite',
                            );

                            if (response.data['status'] == 200) {
                              Get.snackbar(
                                  'Favourite', response.data["message"],
                                  backgroundColor: Colors.green);
                            } else {
                              if (response.data["error"] != null) {
                                Get.snackbar(
                                    'Favourite', response.data["error"],
                                    backgroundColor: Colors.red);
                              } else {
                                Get.snackbar('Favourite',
                                    'something went wrong pls try again ',
                                    backgroundColor: Colors.red);
                              }
                            }
                          }
                          if (value == 2) {
                            print(token);
                            var response = await DioHelper2.deletedata(
                                url: 'favourite/delete',
                                token: token,
                                query: {'book_id': book.id});
                            Get.log(response.data.toString());
                            if (response.data['status'] == 200) {
                              Get.snackbar(
                                  'Favourite', response.data["message"],
                                  backgroundColor: Colors.green);
                            } else {
                              Get.snackbar(
                                  'Favourite', response.data["error"].toString(),
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  Text(
                    book.author ?? 'no one',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    book.status,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    book.username,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 106, 106),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    book.price + ' LE',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 106, 106),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      if (categorylength > 0)
                        Card(
                            margin: const EdgeInsets.only(right: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(book.categories[0].name),
                            )),
                      if (categorylength > 1)
                        Card(
                            margin: const EdgeInsets.only(right: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(book.categories[1].name),
                            )),
                      if (categorylength > 2)
                        Card(
                            margin: const EdgeInsets.only(right: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(book.categories[2].name),
                            )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}

class searchwidget extends StatelessWidget {
  const searchwidget({
    super.key,
    required this.searchcontroller,
    required this.leading,
  });

  final SearchController searchcontroller;
  final Icon leading;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchcontroller,
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          leading: leading,
          trailing: const [Trailing()],
          onTap: () {},
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final keyword = controller.value.text;
        return List.generate(5, (index) => 'Item $index')
            .where((element) =>
                element.toLowerCase().startsWith(keyword.toLowerCase()))
            .map((item) => ListTile(
                  title: Text(item),
                  onTap: () {},
                ));
      },
    );
  }
}

class Trailing extends StatelessWidget {
  const Trailing({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.keyboard_voice),
      onPressed: () {
        print('Use voice command');
      },
    );
  }
}
