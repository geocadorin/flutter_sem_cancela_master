import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/helps/firebase_errors.dart';

class UserRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  createUser({
    @required String email,
    @required String password,
    @required String name,
    @required String customerId,
    @required List<String> entrancesIds,
  }) async {
    List<DocumentReference> listEntrances = [];

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
      final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      await Firestore.instance
          .collection('user')
          .document(currentUser.uid)
          .setData({
        'customerId':
            Firestore.instance.collection('customer').document(customerId),
        'name': name,
        'email': email,
        'profileId': 3,
        'entrances': listEntrances,

        // 1º lat 2º long
      }).then((_) {
        Get.snackbar(
          'Sucesso',
          "Usuário Criado com Sucesso!",
          messageText: Text(
            "Usuário Criado com Sucesso!",
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
}
