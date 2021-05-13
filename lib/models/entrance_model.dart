import 'package:cloud_firestore/cloud_firestore.dart';

class EntranceModel {
  String id;
  String customerId;
  String name;
  int status;

  EntranceModel({this.id, this.name, this.status, this.customerId});

  EntranceModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    status = document.data['status'] as int;
    if (document.data.containsKey('customerId')) {
      customerId = document.data['customerId'].documentID as String;
    }
  }

  EntranceModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as String;
    this.name = json['name'] as String;
    this.status = json['status'] as int;
    this.customerId = json['customer'] as String;
  }

  @override
  String toString() {
    String result = "Id: $id - Nome: $name - Cliente Entrada: $customerId";
    return result;
  }
}
