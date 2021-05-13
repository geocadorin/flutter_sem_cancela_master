import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  String id;
  String customerId;
  String imageUrl;
  String color;
  String model;
  String plate;
  String driverDocument;
  String driverName;
  int sector;
  bool block;
  List<String> entrances;

  VehicleModel({
    this.id,
    this.imageUrl,
    this.model,
    this.color,
    this.plate,
    this.driverDocument,
    this.driverName,
    this.sector,
    this.entrances,
    this.customerId,
  });

  VehicleModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    //imageUrl = document.data['imageUrl'] as String;
    //color = document.data['color'] as String;
    model = document.data['model'] as String;
    plate = document.data['plate'] as String;
    //driverDocument = document.data['driverDocument'] as String;
    //driverName = document.data['driverName'] as String;
    //sector = document.data['sector'] as int;
    if (document.data.containsKey('customerId')) {
      customerId = document.data['customerId'].documentID as String;
    }
    if (document.data.containsKey('entrances')) {
      List list = document.data['entrances'];
      List<String> listIds = [];
      list.forEach((dr) {
        listIds.add(dr.documentID);
      });
      entrances = listIds;
    }
  }

  @override
  String toString() {
    String result = "Id: $id - Nome: $plate ";
    return result;
  }
}
