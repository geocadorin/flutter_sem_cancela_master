import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wmc_scan_master/models/vehicle_model.dart';
import 'package:wmc_scan_master/repository/entrance_repository.dart';
import 'package:wmc_scan_master/repository/vehicle_repository.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class QRCodeController extends GetxController {
  final VehicleRepository repository = VehicleRepository();
  final EntranceRepository entranceRepository = EntranceRepository();

  GlobalKey containerKey = GlobalKey();
  StorageReference storageReference = FirebaseStorage().ref();

  final _isLoading = false.obs;
  get isloading => this._isLoading.value;

  final customerId = "".obs;

  final idToGenerate = "".obs;
  final selected = "".obs;

  List<VehicleModel> allVeicles = [];

  final List listItem = [].obs;

  @override
  Future<void> onReady() async {
    customerId.value = Get.arguments as String;
    await getAllVehicles();
    super.onReady();
  }

  void setSelected(String value) {
    selected.value = value;
    var vehicle = allVeicles.firstWhere((e) => e.plate == selected.value,
        orElse: () => null);
    idToGenerate.value = vehicle.id;
  }

  getAllVehicles() async {
    allVeicles = await repository.getAllVehicles(customerId.value);

    allVeicles.forEach((vehicle) {
      listItem.add(vehicle.plate);
    });

    listItem.sort();

    //selected.value = listItem.last;
    selected.value = null;
  }

  saveScreen() async {
    RenderRepaintBoundary boundary =
        containerKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 60,
        name: "QRCode_${selected.value}");
    print(result);
  }

  void saveQrCode() async {
    RenderRepaintBoundary renderRepaintBoundary =
        containerKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uInt8List = byteData.buffer.asUint8List();

    _isLoading.value = true;

    StorageUploadTask storageUploadTask =
        storageReference.child("QRCode_${selected.value}").putData(uInt8List);

    await storageUploadTask.onComplete;

    await saveScreen();

    _isLoading.value = false;

    Get.snackbar(
      'Sucesso',
      "QR Code Salvo com Sucesso!",
      messageText: Text(
        "QR Code Salvo com Sucesso!",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
    );
  }
}
