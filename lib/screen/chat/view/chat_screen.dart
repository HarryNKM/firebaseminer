import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode node = FocusNode();
  ScrollController scrollcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    node.addListener(
      () {
        if (node.hasFocus) {
          Future.delayed(
              Duration(milliseconds: 300),
              scrollcontroller.animateTo(
                  scrollcontroller.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn) as FutureOr Function()?);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 20,
            ),
            Text("Harry"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.90,
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                controller: scrollcontroller,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? ChatBubble(
                          clipper:
                              ChatBubbleClipper8(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              "hiii",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      : ChatBubble(
                          clipper:
                              ChatBubbleClipper8(type: BubbleType.receiverBubble),
                          backGroundColor: Color(0xffE7E7ED),
                          margin: EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              "do consequat",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                },
              ),
            ),

            SizedBox(
              height:5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.80,
                    child: TextField(
                      focusNode: node,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Type A Message...!"),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
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
