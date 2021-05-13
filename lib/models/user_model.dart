import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String customerId;
  String email;
  String name;
  int profileId;
  List<String> entrances;

  UserModel({
    this.id,
    this.customerId,
    this.email,
    this.name,
    this.profileId,
    this.entrances,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.customerId = json['customerId'];
    this.email = json['email'];
    this.name = json['name'];
    this.profileId = json['profileId'];
    //this.entrances = ['entraces'].cast<String>();
    List list = json['entrances'].cast<String>();
    List<String> listIds = [];
    list.forEach((id) {
      print(id);
      listIds.add(id);
    });
    this.entrances = listIds;
  }

  UserModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    profileId = document.data['profileId'] as int;
    if (document.data.containsKey('customerId')) {
      //customer = CustomerModel.fromJson(document.data['customerId'] as Map<String, dynamic>);
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

  UserModel.fromSnapshot(FirebaseUser currentUser)
      : id = currentUser.uid,
        email = currentUser.email;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "customerId": customerId,
      "email": email,
      "name": name,
      "profileId": profileId,
      "entrances": entrances,
    };
  }
}
