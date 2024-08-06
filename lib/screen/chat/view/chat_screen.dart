import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseminer/screen/users/model/user_model.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/firestore_helper.dart';
import '../../profile/model/profile_model.dart';
import '../controller/chat_controller.dart';
import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode node = FocusNode();
  ScrollController scrollcontroller = ScrollController();
  TextEditingController txtChat = TextEditingController();
  UserModel model = Get.arguments;
  ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    controller.chatMessages();
    node.addListener(
      () {
        if (node.hasFocus) {
          Future.delayed(
              const Duration(milliseconds: 300),
              scrollcontroller.animateTo(
                  scrollcontroller.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn) as FutureOr Function()?);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 20,
            ),
            Text("Harry"),
          ],
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirestoreHelper.helper.chatMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Let,s Start Chatting"));
              } else if (snapshot.hasData) {
                List<ChatModel> chatModelList = [];
                QuerySnapshot? qs = snapshot.data;
                List<QueryDocumentSnapshot> l1 = qs!.docs;
                for (var x in l1) {
                  var id = x.id;
                  Map m1 = x.data() as Map;

                  ChatModel model = ChatModel.mapToModel(m1);
                  model.docId = id;
                  chatModelList.add(model);
                }
                if (chatModelList.isEmpty) {
                  return Center(child: Text("Let's Chat"));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollcontroller,
                      itemCount: chatModelList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: chatModelList[index].uid ==
                                  FirebaseHelper.helper.user!.uid
                              ? ChatBubble(
                                  clipper: ChatBubbleClipper8(
                                      type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  margin: const EdgeInsets.only(top: 20),
                                  backGroundColor:
                                      Theme.of(context).primaryColorLight,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: Text(
                                      "${chatModelList[index].message}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                              : ChatBubble(
                                  clipper: ChatBubbleClipper8(
                                      type: BubbleType.receiverBubble),
                                  backGroundColor: const Color(0xffE7E7ED),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: Text(
                                      "${chatModelList[index].message}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          //Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: txtChat,
                    focusNode: node,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Type A Message...!"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (txtChat.text.isEmpty) {
                    const Text("please enter the message");
                  } else {
                    controller.sendMassage(
                        model.id!, DateTime.now(), txtChat.text);
                    FirestoreHelper.helper.chatMessages();
                    txtChat.clear();
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
/*
   StreamBuilder(
              stream: FirestoreHelper.helper.chatMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Let,s Start Chatting"));
                }
                else if (snapshot.hasData) {
                  List<ChatModel> chatModelList = [];
                  QuerySnapshot? qs = snapshot.data;
                  List<QueryDocumentSnapshot> l1 = qs!.docs;
                  for (var x in l1) {
                    var id = x.id;
                    Map m1 = x.data() as Map;

                    ChatModel model = ChatModel.mapToModel(m1);
                    model.docId = id;
                    chatModelList.add(model);
                  }
                  if(chatModelList.isEmpty)
                    {
                      return Center(child: Text("Let's Chat"));
                    }
                  else
                    {

                    }
                }
              }),
 */
/*
     Container(
              height: MediaQuery.sizeOf(context).height * 0.75,
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                controller: scrollcontroller,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: index % 2 == 0
                        ? ChatBubble(
                            clipper:
                                ChatBubbleClipper8(type: BubbleType.sendBubble),
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 20),
                            backGroundColor:
                                Theme.of(context).primaryColorLight,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: const Text(
                                "hiii",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        : ChatBubble(
                            clipper: ChatBubbleClipper8(
                                type: BubbleType.receiverBubble),
                            backGroundColor: const Color(0xffE7E7ED),
                            margin: const EdgeInsets.only(top: 20),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: const Text(
                                "do consequat",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
 */
