import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/helps/firebase_errors.dart';
import 'package:wmc_scan_master/models/vehicle_model.dart';

class VehicleRepository {
  createVehicle({@required VehicleModel vehicle}) async {
    List<DocumentReference> listEntrances = [];
    List<String> entrancesIds = vehicle.entrances;

    int i = 0;
    while (i < entrancesIds.length) {
      DocumentReference dr =
          Firestore.instance.collection('entrance').document(entrancesIds[i]);
      listEntrances.add(dr);
      i++;
    }

    try {
      print("teste");
      //retorna o usuario criado

      await Firestore.instance.collection('vehicle').document().setData({
        'customerId': Firestore.instance
            .collection('customer')
            .document(vehicle.customerId),
        'color': vehicle.color,
        'driverDocument': vehicle.driverDocument,
        'driverName': vehicle.driverName,
        'entrances': listEntrances,
        'model': vehicle.model,
        'imageUrl': vehicle.imageUrl,
        'plate': vehicle.plate,
        'sector': vehicle.sector,

        // 1º lat 2º long
      }).then((_) async {
        Get.snackbar(
          'Sucesso',
          "Veículo Criado com Sucesso!",
          messageText: Text(
            "Veículo Criado com Sucesso!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
        );
      });
    } catch (e) {
      Get.back();
      print(e);
      Get.defaultDialog(title: "ERRO", content: Text(getErrorString(e.code)));
      return null;
    }
  }

  getAllVehicles(customerId) async {
    var dr = Firestore.instance.collection('customer').document(customerId);
    List<VehicleModel> list = [];

    try {
      await Firestore.instance
          .collection("vehicle")
          .where("customerId", isEqualTo: dr)
          .getDocuments()
          .then((qs) {
        qs.documents.forEach((ds) {
          list.add(VehicleModel.fromDocument(ds));
        });
      });
    } catch (e) {
      print(e);
    }
    return list;
  }
}
