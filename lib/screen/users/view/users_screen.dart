import 'package:firebaseminer/screen/users/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UsersController controller=Get.put(UsersController());

  @override
  void initState() {
    super.initState();
    controller.getAllUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
      ),
      body: Obx(
        ()=> ListView.builder(itemCount: controller.userModelList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                   // color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    // boxShadow: const [
                    //   BoxShadow(
                    //       color: Colors.grey,
                    //       blurRadius: 2,
                    //       spreadRadius: 1,
                    //       blurStyle: BlurStyle.normal)
                    // ]),
                ),
                child: ListTile(

                  onTap: () {

                    Get.toNamed('chat',arguments: controller.userModelList[index]);
                  },
                  leading:  CircleAvatar(
                    child: Text("${controller.userModelList[index].name![0].capitalize}"),
                  ),
                  title:  Text(
                    "${controller.userModelList[index].name}",
                    style: TextStyle(
                        color:  Theme.of(context).primaryColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle:  Text(
                    "+91 ${controller.userModelList[index].phone}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  trailing: const Text(
                    "online",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
