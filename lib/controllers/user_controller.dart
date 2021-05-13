import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/repository/entrance_repository.dart';
import 'package:wmc_scan_master/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository = UserRepository();
  final EntranceRepository entranceRepository = EntranceRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final _isLoading = false.obs;
  get isloading => this._isLoading.value;

  List _userEntrances = [].obs;
  get userEntrances => this._userEntrances;
  set userEntrances(newValue) => this._userEntrances = newValue;

  final _myActivitiesResult = "".obs;
  get myActivitiesResult => this._myActivitiesResult.value;
  set myActivitiesResult(newValue) => this._myActivitiesResult.value = newValue;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final entrances = [].obs;

  final customerId = "".obs;

  @override
  Future<void> onReady() async {
    customerId.value = Get.arguments as String;
    await getEntracesCustomer();
    super.onReady();
  }

  getEntracesCustomer() async {
    _isLoading.value = true;

    var list =
        await entranceRepository.getEntrancesByCustomerID(customerId.value);

    list.forEach((e) {
      print(e);
      entrances.add(e);
    });

    _isLoading.value = false;
  }

  saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      _isLoading.value = true;
      List<String> list = [];

      _userEntrances.forEach((e) {
        list.add(e);
      });

      form.save();

      await repository.createUser(
        name: nameController.text,
        email: emailController.text,
        password: passController.text,
        customerId: customerId.value,
        entrancesIds: list,
      );

      _userEntrances = [].obs;
      _isLoading.value = false;

      emailController.clear();
      passController.clear();
      nameController.clear();

      //form.reset();
    }
  }
}
