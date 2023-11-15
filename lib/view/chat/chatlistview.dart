
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedbookshop/controller/ListchatController.dart';
import 'package:usedbookshop/models/chatpersonmodel.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/styles/styles.dart';
import 'package:usedbookshop/view/chat/chat.dart';

class ListChatView extends StatelessWidget {
  ListChatView({
    super.key,
  });
  final ListchatController controller = Get.put(ListchatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Maindrawer(),

      // backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: GoogleFonts.tiroTelugu(fontSize: 27),
        ),
        backgroundColor: Colors.blue,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          GetBuilder<ListchatController>(
            builder: (_) => !controller.chatlistintial
                ? const SliverToBoxAdapter(child: CircularProgressIndicator())
                : controller.chats.length > 0
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Personchatpar(
                            chat: controller.chats[index],
                          );
                        }, childCount: controller.chats.length),
                      )
                    : SliverToBoxAdapter(
                        child: Container(
                          height: 600,
                          child: Center(
                            child: Text(
                              'You havesn\'t connect any one',
                              style: GoogleFonts.maidenOrange(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
          )
        ],
      ),
    );
  }
}

class Personchatpar extends StatelessWidget {
  final ChatPersonmodel chat;
  const Personchatpar({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print(chat.user.id.toString());
            Get.to(() => ChatScreen(), arguments: chat.user.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      chat.user.imageurl ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU",
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        chat.message.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            color: Colors.grey.withOpacity(0.8), fontSize: 17),
                      ),
                      const SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '3m ago',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.2,
          color: Style.bordercolor,
          margin: const EdgeInsets.only(left: 70),
        )
      ],
    );
  }
}
