import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
      ),
      body: ListView.builder(
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
                  Get.toNamed('chat');
                },
                leading: const CircleAvatar(
                  child: Text("A"),
                ),
                title:  Text(
                  "Harry",
                  style: TextStyle(
                      color:  Theme.of(context).primaryColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                subtitle:  Text(
                  "+91 9173719691",
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
    );
  }
}
