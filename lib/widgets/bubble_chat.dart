import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/message.dart';

class BubbleChatWidget extends StatelessWidget {
  const BubbleChatWidget({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              message.id,
              style: GoogleFonts.cairo(color: Colors.grey),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              message.message,
              style: GoogleFonts.akshar(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class BubbleChatWidgetForFriend extends StatelessWidget {
  const BubbleChatWidgetForFriend({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              message.id,
              style: GoogleFonts.cairo(color: Colors.grey),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Text(
              message.message,
              style: GoogleFonts.akshar(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
