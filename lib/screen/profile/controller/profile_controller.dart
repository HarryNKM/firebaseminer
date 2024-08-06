import 'package:firebaseminer/utils/helper/firestore_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> model = ProfileModel().obs;

  Future<void> getUserDetail() async {
    ProfileModel data = await FirestoreHelper.helper.currentUser();
    model.value = data;
  }
}