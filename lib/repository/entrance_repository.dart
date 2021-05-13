import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:wmc_scan_master/models/entrance_model.dart';

class EntranceRepository {
  createEndtrance(
      {@required String customerId,
      @required String name,
      @required int status}) async {
    try {
      await Firestore.instance.collection('entrance').document().setData({
        'customerId':
            Firestore.instance.collection('customer').document(customerId),
        'name': name,
        'status': status

        // 1º lat 2º long
      }).then((_) {
        Get.snackbar(
          'Sucesso',
          "Portaria Criada com Sucesso!",
          messageText: Text(
            "Portaria Criada com Sucesso!",
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
      print(e);
    }
  }

  Future<List<Map<String, String>>> getEntrancesByCustomerID(
      String customerId) async {
    DocumentReference dr =
        Firestore.instance.collection('customer').document(customerId);
    List<Map<String, String>> entrances = [];
    try {
      await Firestore.instance
          .collection('entrance')
          .where('customerId', isEqualTo: dr)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          var entrance = EntranceModel.fromDocument(element);
          if (entrance != null) {
            var entranceMap = {
              "display": entrance.name,
              "value": entrance.id,
            };
            entrances.add(entranceMap);
          }
        });
      });
    } catch (e) {
      print(e);
      Get.defaultDialog(
          title: "ERRO",
          content: Text("Ocorreu um erro ao carregar os dados "));
      return null;
    }
    return entrances;
  }
}
