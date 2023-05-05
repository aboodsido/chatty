import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/models/message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bubble_chat.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController textFieldController = TextEditingController();

  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/images/chat.png',
                    width: 30,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Chatty',
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ],
              ),
              backgroundColor: kPrimaryColor,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) =>
                        messageList[index].id == email
                            ? BubbleChatWidget(message: messageList[index])
                            : BubbleChatWidgetForFriend(
                                message: messageList[index],
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textFieldController,
                          // onSubmitted: (message) {
                          //   messages.add({
                          //     kMessage: message,
                          //     kCreatedAt: DateTime.now(),
                          //     kEmailId: email,
                          //   });
                          //   textFieldController.clear();
                          //   _scrollDown();
                          // },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              color: kPrimaryColor,
                              onPressed: () {
                                messages.add({
                                  kMessage: textFieldController.text,
                                  kCreatedAt: DateTime.now(),
                                  kEmailId: email,
                                });
                                textFieldController.clear();
                                _scrollDown();
                              },
                              icon: const Icon(Icons.send),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Send Message..',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                'Loading...',
                style: GoogleFonts.cairo(fontSize: 30),
              ),
            ),
          );
        }
      },
    );
  }
}
