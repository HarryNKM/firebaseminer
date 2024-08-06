import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:firebaseminer/utils/helper/firestore_helper.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  Future<void> sendMassage(
      String user2id, DateTime date, String message) async {
    await FirestoreHelper.helper.checkChatId(
        FirebaseHelper.helper.user!.uid, user2id, date, message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatMessages() {
    return FirestoreHelper.helper.chatMessages();
  }
}