import 'package:get/get.dart';
import 'package:wmc_scan_master/models/user_model.dart';
import 'package:wmc_scan_master/ui/pages/entrances.dart';
import 'package:wmc_scan_master/ui/pages/qrCode.dart';
import 'package:wmc_scan_master/ui/pages/user.dart';
import 'package:wmc_scan_master/ui/pages/vehicle.dart';

class HomeController extends GetxController {
  final user = UserModel().obs;

  @override
  void onReady() {
    user.value = Get.arguments as UserModel;
    super.onReady();
  }

  toEntrance() {
    //ir para pagina de portarias passando dados necessários.
    Get.to(() => EntrancesPage(), arguments: user.value.customerId);
  }

  toUser() {
    Get.to(() => UserPage(), arguments: user.value.customerId);
  }

  toVehicle() {
    Get.to(() => VehiclePage(), arguments: user.value.customerId);
  }

  toQR() {
    Get.to(() => QrCodePage(), arguments: user.value.customerId);
  }
}
