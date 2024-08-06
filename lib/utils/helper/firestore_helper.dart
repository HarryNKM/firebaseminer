import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';

import '../../screen/profile/model/profile_model.dart';
import '../../screen/users/model/user_model.dart';

class FirestoreHelper {
  static FirestoreHelper helper = FirestoreHelper._();

  FirestoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;
  String? id;

  void getUserUid() {
    userUid = FirebaseHelper.helper.user!.uid;
  }

  Future<ProfileModel> currentUser() async {
    getUserUid();
    DocumentSnapshot ds = await firestore.collection('user').doc(userUid).get();
    Map? model = ds.data() as Map?;
    ProfileModel data = ProfileModel.mapToModel(
        model ?? {"name": "", "email": "", "phone": ""});
    return data;
  }
  Future<void> userProfile(ProfileModel m1) async {
    getUserUid();
    await firestore.collection('user').doc(userUid).set(m1.modelToMap());
  }

  Future<void> checkChatId(
      String myId, String user2id, DateTime date, String message) async {
    if (id == null) {
      DocumentReference dr = await firestore
          .collection('chat')
          .add({'Userid1': myId, 'Userid2': user2id});

      id = dr.id;
      sendMessage(id: id!, message: message, date: date);
    } else {
      sendMessage(id: id!, message: message, date: date);
    }
  }

  Future<List<UserModel>> getAllUser(ProfileModel p1) async {
    List<UserModel> listData = [];
    //
    QuerySnapshot qs = await firestore
        .collection('user')
        .where("phone", isNotEqualTo: p1.phone)
        .get();
    List<QueryDocumentSnapshot> document = qs.docs;

    for (var x in document) {
      var ket = x.id;
      Map m1 = x.data() as Map;

      UserModel model = UserModel.mapToModel(m1);
      model.id = ket;
      listData.add(model);
    }
    return listData;
  }

  Future<String?> getChatDocId(String myId, String user2id) async {
    QuerySnapshot qs = await firestore
        .collection('chat')
        .where('Userid1', isEqualTo: myId)
        .where('Userid2', isEqualTo: user2id)
        .get();
    List<QueryDocumentSnapshot> l1 = qs.docs;
    if (l1.isNotEmpty) {
      id = l1[0].id;
      return id;
    } else {
      QuerySnapshot qs = await firestore
          .collection('chat')
          .where('Userid2', isEqualTo: myId)
          .where('Userid1', isEqualTo: user2id)
          .get();
      List<QueryDocumentSnapshot> l2 = qs.docs;
      if (l2.isNotEmpty) {
        id = l2[0].id;
        return id;
      } else {
        id = null;
        return id;
      }
    }
  }

  void sendMessage(
      {required String id, required String message, required DateTime date}) {
    firestore.collection("chat").doc(id).collection('msg').add({
      "message": message,
      'uid': FirebaseHelper.helper.user!.uid,
      "datetime": date
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatMessages() {
    return firestore
        .collection("chat")
        .doc(id)
        .collection('msg')
        .orderBy('datetime')
        .snapshots();
  }

  void deleteMyChat(String uid) {
    firestore.collection('chat').doc(id).collection('msg').doc(uid).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allConversationUser() {
    return firestore.collection('chat').snapshots();
  }
  Future<UserModel> getAllChat(userid) async {
    DocumentSnapshot ds = await firestore.collection('user').doc(userid).get();

    Map m1 = ds.data() as Map;

    UserModel model = UserModel.mapToModel(m1);
    model.id = ds.id;

    return model;
  }
}

