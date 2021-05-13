import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/models/vehicle_model.dart';
import 'package:wmc_scan_master/repository/entrance_repository.dart';
import 'package:wmc_scan_master/repository/vehicle_repository.dart';

class VehicleController extends GetxController {
  final VehicleRepository repository = VehicleRepository();
  final EntranceRepository entranceRepository = EntranceRepository();

  final TextEditingController colorController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();

  final _isLoading = false.obs;
  get isloading => this._isLoading.value;

  List _vehicleEntrances = [].obs;
  get vehicleEntrances => this._vehicleEntrances;
  set vehicleEntrances(newValue) => this._vehicleEntrances = newValue;

  final _myActivitiesResult = "".obs;
  get myActivitiesResult => this._myActivitiesResult.value;
  set myActivitiesResult(newValue) => this._myActivitiesResult.value = newValue;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final entrances = [].obs;

  final customerId = "".obs;

  var allVeicles = [].obs;

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

  getAllVehicles() async {
    allVeicles = await repository.getAllVehicles(customerId).obs;
  }

  saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      _isLoading.value = true;
      List<String> list = [];

      _vehicleEntrances.forEach((e) {
        list.add(e);
      });

      form.save();

      VehicleModel vehicle = VehicleModel(
          color: colorController.text,
          customerId: customerId.value,
          driverDocument: documentController.text,
          driverName: nameController.text,
          entrances: list,
          imageUrl: "",
          model: modelController.text,
          plate: plateController.text.toUpperCase(),
          sector: int.parse(sectorController.text));

      await repository.createVehicle(vehicle: vehicle);

      _vehicleEntrances = [].obs;
      _isLoading.value = false;

      colorController.clear();
      documentController.clear();
      modelController.clear();
      nameController.clear();
      plateController.clear();
      sectorController.clear();

      //form.reset();
    }
  }
}
