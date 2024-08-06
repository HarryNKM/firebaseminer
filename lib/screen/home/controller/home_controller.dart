import 'package:get/get.dart';

import '../../users/model/user_model.dart';

class HomeController extends GetxController {
  RxList<UserModel> userList = <UserModel>[].obs;
}