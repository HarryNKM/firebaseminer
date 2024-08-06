import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:firebaseminer/screen/home/controller/home_controller.dart';
import 'package:firebaseminer/screen/profile/controller/profile_controller.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:firebaseminer/utils/helper/firestore_helper.dart';
import 'package:firebaseminer/utils/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.put(ProfileController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          TextButton.icon(
            onPressed: () {
              FirebaseHelper.helper.signout();
              Get.offAllNamed('signin');
              DelightToastBar(
                builder: (context) => const ToastCard(
                  title: Text("Signed Out"),
                  leading: Icon(Icons.logout),
                ),
              ).show(context);
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Colors.red.shade900,
            ),
            label: Text("Log Out"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          profileController.getUserDetail();
          Get.toNamed('user');
        },
        child: Icon(Icons.chat),
      ),
      body: StreamBuilder(stream: FirestoreHelper.helper.allConversationUser(), builder: (context, snapshot) {
        if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
        else if(snapshot.hasData)
          {
          homeController.userList.clear();
          QuerySnapshot? qs = snapshot.data;
          List<QueryDocumentSnapshot> qds = qs!.docs;
          for (var x in qds) {
          Map m1 = x.data() as Map;
          if (m1['Userid1'] == FirebaseHelper.helper.user!.uid) {
            FirestoreHelper.helper
                .getAllChat(m1['Userid2'])
                .then(
                  (value) {
                homeController.userList.add(value);
              },
            );
          } else if (m1['Userid2'] ==
              FirebaseHelper.helper.user!.uid) {
            FirestoreHelper.helper
                .getAllChat(m1['Userid1'])
                .then(
                  (value) {
                homeController.userList.add(value);
              },
            );
          }
          }
            return Obx(
              ()=>ListView.builder(
                itemCount: homeController.userList.length
              ,itemBuilder: (context, index) {
                return ListTile (
                  onTap: () {
                    Get.toNamed('chat',arguments: homeController.userList[index]);
                  },
                  leading:  CircleAvatar(
                    child: Text("${homeController.userList[index].name![0].capitalize}"),
                  ),
                  title:  Text(
                    "${homeController.userList[index].name}",
                    style: TextStyle(
                        color:  Theme.of(context).primaryColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle:  Text(
                    "+91 ${homeController.userList[index].phone}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  trailing: const Text(
                    "online",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              },),
            );
          }
        return Center(child: CircularProgressIndicator());
      },)
    );
  }
}
