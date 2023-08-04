import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../helper/show_snackBar.dart';
import '../models/message.dart';
import '../widgets/bubble_chat.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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

    List<Message> messageList = [];
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
              style:
                  GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 22),
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messageList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) =>
                      messageList[index].id == email
                          ? BubbleChatWidget(message: messageList[index])
                          : BubbleChatWidgetForFriend(
                              message: messageList[index],
                            ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: kPrimaryColor,
                        onPressed: () {
                          if (textFieldController.text.isEmpty) {
                            showSnackBar(
                                context, 'Please enter a message', Colors.red);
                          } else {
                            BlocProvider.of<ChatCubit>(context).addMessage(
                                message: textFieldController.text,
                                email: email);
                            textFieldController.clear();
                            _scrollDown();
                          }
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
  }
}
