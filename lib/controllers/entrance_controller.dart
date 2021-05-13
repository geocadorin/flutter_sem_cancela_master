import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/repository/entrance_repository.dart';

class EntranceController extends GetxController {
  final EntranceRepository repository = EntranceRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  get isloading => this._isLoading.value;

  final customerId = "".obs;

  @override
  void onReady() {
    customerId.value = Get.arguments as String;
    super.onReady();
  }

  Future<void> createEntrance() async {
    print("chamou");
    if (formKey.currentState.validate()) {
      _isLoading.value = true;
      await repository.createEndtrance(
        customerId: customerId.value,
        name: nameController.text,
        status: int.parse(statusController.text),
      );
      _isLoading.value = false;

      nameController.text = "";
      statusController.text = "";
    }
  }
}
