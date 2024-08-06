import 'package:firebaseminer/screen/users/model/user_model.dart';
import 'package:firebaseminer/utils/helper/firestore_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../profile/controller/profile_controller.dart';

class UsersController extends GetxController {
  RxList<UserModel> userModelList = <UserModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());
  Future<void> getAllUser() async {
    List<UserModel>? model =
        await FirestoreHelper.helper.getAllUser(profileController.model.value);
    userModelList.value = model;
  }
}
