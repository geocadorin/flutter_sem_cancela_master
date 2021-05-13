import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmc_scan_master/helps/firebase_errors.dart';
import 'package:wmc_scan_master/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthRepository {
  //GetStorage box = GetStorage();

  //usuarioToStorage(UserModel user) async {
  //  await box.write('auth', user);
  //  UserModel usuario = await box.read('auth');
  //  print(usuario.email);
  //}
//
  //Future<UserModel> usuarioFromStorage() async {
  //  UserModel usuario = await box.read('auth');
  //  return usuario;
  //}
//
  //deleteUserStorage() {
  //  box.remove('usuario');
  //}

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getUser(String uid) async {
    UserModel user;
    await Firestore.instance
        .collection('user')
        .document(uid)
        .get()
        .then((value) {
      user = UserModel.fromDocument(value);
    });

    return user;
  }

  //Retorna o usuarioLogado
  Stream<UserModel> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged
      .map((FirebaseUser currentUser) => UserModel.fromSnapshot(currentUser));

  //Criar User
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      //retorna o usuario criado
      final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      //Atualizando o nome dousuario
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;

      await currentUser.updateProfile(userUpdateInfo);
      await currentUser.reload();
      return UserModel.fromSnapshot(currentUser);
    } catch (e) {
      Get.back();
      print(e);
      Get.defaultDialog(title: "ERROR", content: Text(getErrorString(e.code)));
      return null;
    }
  }

  //Efetua o Login do usuario
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      var user = UserModel.fromSnapshot(currentUser);
      var userFull = await getUser(user.id);

      return userFull;
    } catch (e) {
      Get.back();
      print(e);

      Get.defaultDialog(title: "ERROR", content: Text(getErrorString(e.code)));
      return null;
    }
  }

  //Desloga o usuario
  signOut() {
    return _firebaseAuth.signOut();
  }
}
