import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wmc_scan_master/models/user_model.dart';
import 'package:wmc_scan_master/repository/auth_repository.dart';
import 'package:wmc_scan_master/ui/pages/home.dart';

class AuthController extends GetxController {
  final AuthRepository repository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GetStorage box = GetStorage('scan_wmc_master');

  final _user = UserModel().obs;

  get user => this._user.value;
  set user(newValue) => this._user.value = newValue;

  final _isLoading = false.obs;

  get isloading => this._isLoading.value;
  set isloading(newValue) => this._isLoading.value = newValue;

  @override
  Future<void> onReady() async {
    await isLogged();
    super.onReady();
  }

  void login() async {
    if (formKey.currentState.validate()) {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      UserModel user = await repository.signInWithEmailAndPassword(
          emailController.text, passController.text);

      print(user.email);

      if (user != null) {
        await box.write("auth", user);
        emailController.text = "";
        passController.text = "";
        //Get.offAll(HomePage());
        Get.offAll(() => HomePage(), arguments: user);
      }
    }
  }

  isLogged() async {
    _isLoading.value = true;
    if (box.hasData("auth")) {
      var json = await box.read("auth");
      _user.value = UserModel.fromJson(json);
      var user = _user.value;
      Get.offAll(() => HomePage(), arguments: user);
    }
    _isLoading.value = false;
  }
}
//wmcmaster@wmc.com
